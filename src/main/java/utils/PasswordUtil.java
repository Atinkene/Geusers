package utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil 
{

    // Cost factor — higher = slower = more secure
    private static final int COST = 12;

    // Hashes a plain-text password
    public static String hash(String plainPassword) 
    {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(COST));
    }

    // Checks a plain-text password against a stored hash
    public static boolean verify(String plainPassword, String storedHash) 
    {
        if (storedHash == null || !storedHash.startsWith("$2")) return false;
        return BCrypt.checkpw(plainPassword, storedHash);
    }
}