-- Create user_roles table to store admin/customer assignments
create table if not exists public.user_roles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  role text not null,
  created_at timestamptz default now(),
  unique(user_id, role)
);

-- Index for faster lookups
create index if not exists idx_user_roles_user_id_role on public.user_roles (user_id, role);

-- Create helper function to check if current user is admin
create or replace function public.is_admin() returns boolean
language sql stable as $$
  select exists (
    select 1
    from public.user_roles ur
    where ur.user_id = auth.uid() and ur.role = 'admin'
  );
$$;

-- Update orders table RLS policies for admin access
-- Allow users to insert their own orders
create policy "orders_insert_own" on public.orders
for insert
with check (auth.role() = 'authenticated' AND user_id = auth.uid());

-- Allow users to select their own orders
create policy "orders_select_own" on public.orders
for select
using (user_id = auth.uid());

-- Allow admins full access to all orders
create policy "orders_admin_access" on public.orders
for all
using (public.is_admin())
with check (public.is_admin());
