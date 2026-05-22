package servlets;

import beans.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.UserService;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet
{
    private static final String LOGIN_VIEW = "/login.jsp";

    // Displays the login page
    @Override
    protected void doGet(
            HttpServletRequest  request,
            HttpServletResponse response
    ) throws ServletException, IOException
    {
        // Redirect to list if already authenticated
        HttpSession session     = request.getSession(false);
        User        currentUser = (session != null)
                                ? (User) session.getAttribute("currentUser")
                                : null;

        if (currentUser != null)
        {
            response.sendRedirect(request.getContextPath() + "/list");
            return;
        }

        request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
    }

    // Processes login form submission
    @Override
    protected void doPost(
            HttpServletRequest  request,
            HttpServletResponse response
    ) throws ServletException, IOException
    {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try
        {
            User user = UserService.authenticate(username, password);

            if (user == null)
            {
                // Wrong credentials — back to login with error
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
                return;
            }

            // Create session and store authenticated user
            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", user);
            session.setMaxInactiveInterval(1800); // 30 minutes

            response.sendRedirect(request.getContextPath() + "/list");
        }
        catch (Exception e)
        {
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
        }
    }
}