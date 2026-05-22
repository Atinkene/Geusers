package filters;

import beans.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter
{
    @Override
    public void init(FilterConfig config) throws ServletException {}

    @Override
    public void doFilter(
            ServletRequest  request,
            ServletResponse response,
            FilterChain     chain
    ) throws IOException, ServletException
    {
        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getServletPath();

        // Public routes - no authentication required
        boolean isPublic = path.equals("/login")
                        || path.startsWith("/assets/");

        if (isPublic)
        {
            chain.doFilter(request, response);
            return;
        }

        // Check session for authenticated user
        HttpSession session     = req.getSession(false);
        User        currentUser = (session != null)
                                ? (User) session.getAttribute("currentUser")
                                : null;

        if (currentUser == null)
        {
            // Not authenticated - redirect to login
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Authenticated - continue to requested resource
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}