using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace course_management_system.Security
{
    public class PasswordHelper
    {
        public static string HashPassword(string password)
        {
            byte[] salt = new byte[16];

            using (RandomNumberGenerator rng =
                   RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            using (var pbkdf2 =
                   new Rfc2898DeriveBytes(password, salt, 100000))
            {
                byte[] hash = pbkdf2.GetBytes(32);

                return Convert.ToBase64String(salt)
                       + ":"
                       + Convert.ToBase64String(hash);
            }
        }

        public static bool VerifyPassword(
            string password,
            string storedHash)
        {
            try
            {
                string[] parts = storedHash.Split(':');

                if (parts.Length != 2)
                    return false;

                byte[] salt =
                    Convert.FromBase64String(parts[0]);

                byte[] storedHashBytes =
                    Convert.FromBase64String(parts[1]);

                using (var pbkdf2 =
                       new Rfc2898DeriveBytes(password, salt, 100000))
                {
                    byte[] newHash = pbkdf2.GetBytes(32);

                    return AreEqual(newHash, storedHashBytes);
                }
            }
            catch
            {
                return false;
            }
        }

        private static bool AreEqual(byte[] first, byte[] second)
        {
            if (first.Length != second.Length)
                return false;

            int result = 0;

            for (int i = 0; i < first.Length; i++)
            {
                result |= first[i] ^ second[i];
            }

            return result == 0;
        }
    }

}