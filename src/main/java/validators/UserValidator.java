package validators;

public class UserValidator 
{

    // Returns an error message, or null if valid
    public static String validate(String firstName, String lastName, String username, String password) 
    {

        if (firstName == null || firstName.trim().isEmpty())
            return "First name is required";

        if (firstName.trim().length() > 50)
            return "First name must not exceed 50 characters";

        if (lastName == null || lastName.trim().isEmpty())
            return "Last name is required";

        if (lastName.trim().length() > 50)
            return "Last name must not exceed 50 characters";

        if (username == null || username.trim().isEmpty())
            return "Username is required";

        if (username.trim().length() < 3 || username.trim().length() > 30)
            return "Username must be between 3 and 30 characters";

        if (!username.trim().matches("[a-zA-Z0-9_]+"))
            return "Username may only contain letters, digits and underscores";

        if (password == null || password.isEmpty())
            return "Password is required";

        if (password.length() < 4)
            return "Password must be at least 4 characters";

        // All rules passed
        return null;
    }

    // Validates only the fields that are allowed to change on update
    public static String validateUpdate(String firstName, String lastName, String username) 
    {

        if (firstName == null || firstName.trim().isEmpty())
            return "First name is required";

        if (firstName.trim().length() > 50)
            return "First name must not exceed 50 characters";

        if (lastName == null || lastName.trim().isEmpty())
            return "Last name is required";

        if (lastName.trim().length() > 50)
            return "Last name must not exceed 50 characters";

        if (username == null || username.trim().isEmpty())
            return "Username is required";

        if (username.trim().length() < 3 || username.trim().length() > 30)
            return "Username must be between 3 and 30 characters";

        if (!username.trim().matches("[a-zA-Z0-9_]+"))
            return "Username may only contain letters, digits and underscores";

        return null;
    }
}