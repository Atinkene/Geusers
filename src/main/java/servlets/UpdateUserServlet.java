package servlets;

import beans.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.UserService;

import java.io.IOException;

@WebServlet("/edit-user")
public class UpdateUserServlet extends HttpServlet
{
    private static final String EDIT_VIEW = "/WEB-INF/views/Utilisateurs/edit-user.jsp";

    // Displays the edit form prefilled with user data
    @Override
    protected void doGet(
            HttpServletRequest  request,
            HttpServletResponse response
    ) throws ServletException, IOException
    {
        String idParam = request.getParameter("id");

        if (idParam == null || !idParam.matches("[0-9]+"))
        {
            response.sendRedirect(request.getContextPath() + "/list");
            return;
        }

        try
        {
            User user = UserService.findById(Integer.parseInt(idParam));

            if (user == null)
            {
                response.sendRedirect(request.getContextPath() + "/list");
                return;
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher(EDIT_VIEW).forward(request, response);
        }
        catch (Exception e)
        {
            response.sendRedirect(request.getContextPath() + "/list");
        }
    }

    // Processes form submission
    @Override
    protected void doPost(
            HttpServletRequest  request,
            HttpServletResponse response
    ) throws ServletException, IOException
    {
        String idParam    = request.getParameter("id");
        String firstName  = request.getParameter("firstName");
        String lastName   = request.getParameter("lastName");
        String username   = request.getParameter("username");
        String password   = request.getParameter("password");

        if (idParam == null || !idParam.matches("[0-9]+"))
        {
            response.sendRedirect(request.getContextPath() + "/list");
            return;
        }

        int id = Integer.parseInt(idParam);

        try
        {
            String error = UserService.update(id, firstName, lastName, username, password);

            if (error != null)
            {
                // Validation failed — back to form with error and input values
                User user = new User(firstName, lastName, username, null);
                user.setId(id);

                request.setAttribute("error",  error);
                request.setAttribute("user",   user);
                request.getRequestDispatcher(EDIT_VIEW).forward(request, response);
                return;
            }

            // Success — redirect to list
            request.getSession().setAttribute("success", "User updated successfully");
            response.sendRedirect(request.getContextPath() + "/list");
        }
        catch (Exception e)
        {
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher(EDIT_VIEW).forward(request, response);
        }
    }
}