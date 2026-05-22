package services;

import beans.User;
import dao.UserDao;
import utils.PasswordUtil;
import validators.UserValidator;

import java.sql.SQLException;
import java.util.ArrayList;

public class UserService
{
    // Returns all users
    public static ArrayList<User> findAll() throws SQLException
    {
        return UserDao.findAll();
    }

    // Returns a single user by id
    public static User findById(int id) throws SQLException
    {
        return UserDao.findById(id);
    }

    // Validates, hashes password then saves - returns error or null on success
    public static String create(
            String firstName,
            String lastName,
            String username,
            String password
    ) throws SQLException
    {
        // Validate inputs
        String error = UserValidator.validate(firstName, lastName, username, password);
        if (error != null) return error;

        // Check username uniqueness
        if (UserDao.findByUsername(username) != null)
            return "Username already taken";

        // Hash password then persist
        User user = new User(
                firstName.trim(),
                lastName.trim(),
                username.trim(),
                PasswordUtil.hash(password)
        );

        UserDao.save(user);
        return null;
    }

    // Validates, hashes password then updates - returns error or null on success
    public static String update(
            int    id,
            String firstName,
            String lastName,
            String username,
            String password
    ) throws SQLException
    {
        // Validate inputs
        String error = UserValidator.validate(firstName, lastName, username, password);
        if (error != null) return error;

        // Check username uniqueness - exclude current user
        User existing = UserDao.findByUsername(username);
        if (existing != null && existing.getId() != id)
            return "Username already taken";

        // Hash password then persist
        User user = new User(
                firstName.trim(),
                lastName.trim(),
                username.trim(),
                PasswordUtil.hash(password)
        );

        boolean updated = UserDao.update(id, user);
        if (!updated) return "User not found";

        return null;
    }

    // Deletes a user by id - returns error or null on success
    public static String delete(int id) throws SQLException
    {
        boolean deleted = UserDao.delete(id);
        if (!deleted) return "User not found";
        return null;
    }

    // Authenticates a user - returns User on success, null on failure
    public static User authenticate(String username, String password) throws SQLException
    {
        if (username == null || password == null) return null;

        // Fetch user with hash
        User user = UserDao.findByUsername(username);
        if (user == null) return null;

        // Verify password against stored hash
        if (!PasswordUtil.verify(password, user.getPassword())) return null;

        // Clear hash before returning - never stored in session
        user.setPassword(null);
        return user;
    }
}