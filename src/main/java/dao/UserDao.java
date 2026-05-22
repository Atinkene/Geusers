package dao;

import beans.User;
import config.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;

public class UserDao
{
    // Maps a ResultSet row to a User object
    private static User map(ResultSet rs) throws SQLException
    {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setUsername(rs.getString("username"));
        return user;
    }

    // Returns all users — password excluded
    public static ArrayList<User> findAll() throws SQLException
    {
        ArrayList<User> users = new ArrayList<>();
        String sql = "SELECT id, first_name, last_name, username FROM users ORDER BY id";

        try (
            Connection        conn = DatabaseConnection.getConnection();
            PreparedStatement ps   = conn.prepareStatement(sql);
            ResultSet         rs   = ps.executeQuery()
        )
        {
            while (rs.next())
            {
                users.add(map(rs));
            }
        }
        return users;
    }

    // Returns a single user by id — password excluded
    public static User findById(int id) throws SQLException
    {
        String sql = "SELECT id, first_name, last_name, username FROM users WHERE id = ?";

        try (
            Connection        conn = DatabaseConnection.getConnection();
            PreparedStatement ps   = conn.prepareStatement(sql)
        )
        {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery())
            {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    // Returns a user with password hash — used only for authentication
    public static User findByUsername(String username) throws SQLException
    {
        String sql = "SELECT id, first_name, last_name, username, password "
                   + "FROM users WHERE username = ?";

        try (
            Connection        conn = DatabaseConnection.getConnection();
            PreparedStatement ps   = conn.prepareStatement(sql)
        )
        {
            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery())
            {
                if (rs.next())
                {
                    User user = map(rs);
                    user.setPassword(rs.getString("password")); // hash needed for verification
                    return user;
                }
            }
        }
        return null;
    }

    // Inserts a new user — password must already be hashed
    public static void save(User user) throws SQLException
    {
        String sql = "INSERT INTO users (first_name, last_name, username, password) "
                   + "VALUES (?, ?, ?, ?)";

        try (
            Connection        conn = DatabaseConnection.getConnection();
            PreparedStatement ps   = conn.prepareStatement(sql)
        )
        {
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUsername());
            ps.setString(4, user.getPassword());
            ps.executeUpdate();
        }
    }

    // Updates an existing user — password must already be hashed
    public static boolean update(int id, User user) throws SQLException
    {
        String sql = "UPDATE users "
                   + "SET first_name=?, last_name=?, username=?, password=? "
                   + "WHERE id=?";

        try (
            Connection        conn = DatabaseConnection.getConnection();
            PreparedStatement ps   = conn.prepareStatement(sql)
        )
        {
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUsername());
            ps.setString(4, user.getPassword());
            ps.setInt(5, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Deletes a user by id
    public static boolean delete(int id) throws SQLException
    {
        String sql = "DELETE FROM users WHERE id = ?";

        try (
            Connection        conn = DatabaseConnection.getConnection();
            PreparedStatement ps   = conn.prepareStatement(sql)
        )
        {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}