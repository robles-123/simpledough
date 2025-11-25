/**
 * Admin Setup Helper
 * 
 * MANUAL STEPS:
 * 1. In your Supabase project, go to SQL Editor and run `supabase/create_roles.sql` first.
 * 2. Register admin@gmail.com / admin123 via the app UI (use the Register page).
 * 3. In Supabase Dashboard > Table Editor > user_roles, manually insert a row:
 *    - user_id: <paste the UUID of admin@gmail.com from auth.users table>
 *    - role: 'admin'
 * 
 * ALTERNATIVE - Use this script:
 * 1. Go to Supabase Dashboard > SQL Editor.
 * 2. Find the UUID of admin@gmail.com:
 *    SELECT id FROM auth.users WHERE email = 'admin@gmail.com';
 * 3. Run:
 *    INSERT INTO public.user_roles (user_id, role) 
 *    VALUES ('<UUID-from-step-2>', 'admin');
 * 
 * After this, admin@gmail.com will have admin access.
 * The app's AuthContext will automatically detect the admin role and you'll see admin features.
 */

// This file is for reference. Use SQL Editor in Supabase to run the commands above.
