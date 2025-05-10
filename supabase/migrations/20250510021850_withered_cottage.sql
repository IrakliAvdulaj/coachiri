/*
  # Add service role policies for admin credentials

  1. Security Changes
    - Add policy for service role to create admin users
    - Add policy for service role to update admin users
    - Add policy for service role to delete admin users
*/

-- Allow service role to insert admin users
CREATE POLICY "Service role can create admin users"
ON public.admin_credentials
FOR INSERT
TO authenticated
WITH CHECK (auth.jwt() ->> 'role' = 'service_role');

-- Allow service role to update admin users
CREATE POLICY "Service role can update admin users"
ON public.admin_credentials
FOR UPDATE
TO authenticated
USING (auth.jwt() ->> 'role' = 'service_role')
WITH CHECK (auth.jwt() ->> 'role' = 'service_role');

-- Allow service role to delete admin users
CREATE POLICY "Service role can delete admin users"
ON public.admin_credentials
FOR DELETE
TO authenticated
USING (auth.jwt() ->> 'role' = 'service_role');