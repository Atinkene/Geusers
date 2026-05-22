package config;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnection 
{

    private static DataSource dataSource;

    // Load DataSource once via JNDI (credentials live in GEUSERS1.xml)
    static 
    {
        try 
        {
            Context initCtx = new InitialContext();
            Context envCtx  = (Context) initCtx.lookup("java:comp/env");
            dataSource       = (DataSource) envCtx.lookup("jdbc/geusers");
        } 
        
        catch (Exception e) 
        {
            throw new RuntimeException("DataSource not found: " + e.getMessage());
        }
    }

    // Returns a connection from the pool
    public static Connection getConnection() throws SQLException 
    {
        return dataSource.getConnection();
    }
}