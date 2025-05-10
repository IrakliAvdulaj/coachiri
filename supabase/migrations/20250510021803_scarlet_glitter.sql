/*
  # Add admin credentials policies

  1. Changes
    - Add INSERT policy for admin_credentials table
    - Add UPDATE policy for admin_credentials table
    - Add DELETE policy for admin_credentials table

  2. Security
    - Enable RLS on admin_credentials table (already enabled)
    - Add policies to allow service role to manage admin users
    - Maintain existing SELECT policy for authenticated users
*/

-- Allow service role to insert admin users
CREATE POLICY "Service role can create admin users"
ON public.admin_credentials
FOR INSERT
TO authenticated
USING (auth.jwt() ->> 'role' = 'service_role');

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