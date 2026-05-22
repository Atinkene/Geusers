package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.UserService;

import java.io.IOException;

@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet
{
    // Deletes a user then redirects to list
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
            String error = UserService.delete(Integer.parseInt(idParam));

            if (error != null)
            {
                request.getSession().setAttribute("error", error);
            }
            else
            {
                request.getSession().setAttribute("success", "User deleted successfully");
            }
        }
        catch (Exception e)
        {
            request.getSession().setAttribute("error", "An error occurred. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/list");
    }
}