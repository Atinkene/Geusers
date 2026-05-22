package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.UserService;

import java.io.IOException;

@WebServlet("/add-user")
public class AddUserServlet extends HttpServlet
{
    private static final String ADD_VIEW = "/WEB-INF/views/Utilisateurs/add-user.jsp";

    // Displays the add user form
    @Override
    protected void doGet(
            HttpServletRequest  request,
            HttpServletResponse response
    ) throws ServletException, IOException
    {
        request.getRequestDispatcher(ADD_VIEW).forward(request, response);
    }

    // Processes form submission
    @Override
    protected void doPost(
            HttpServletRequest  request,
            HttpServletResponse response
    ) throws ServletException, IOException
    {
        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String username  = request.getParameter("username");
        String password  = request.getParameter("password");

        try
        {
            String error = UserService.create(firstName, lastName, username, password);

            if (error != null)
            {
                // Validation failed — back to form with error and input values
                request.setAttribute("error",     error);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName",  lastName);
                request.setAttribute("username",  username);
                request.getRequestDispatcher(ADD_VIEW).forward(request, response);
                return;
            }

            // Success — redirect to list
            request.getSession().setAttribute("success", "User created successfully");
            response.sendRedirect(request.getContextPath() + "/list");
        }
        catch (Exception e)
        {
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher(ADD_VIEW).forward(request, response);
        }
    }
}