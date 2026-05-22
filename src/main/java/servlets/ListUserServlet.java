package servlets;

import beans.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.UserService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.stream.Collectors;

@WebServlet("/list")
public class ListUserServlet extends HttpServlet
{
    private static final String LIST_VIEW  = "/WEB-INF/views/Utilisateurs/list-users.jsp";
    private static final int    PAGE_SIZE  = 8;

    @Override
    protected void doGet(
            HttpServletRequest  request,
            HttpServletResponse response
    ) throws ServletException, IOException
    {
        try
        {
            ArrayList<User> users = UserService.findAll();

            // ── Search ───────────────────────────────────
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty())
            {
                String term = search.trim().toLowerCase();
                users = users.stream()
                        .filter(u ->
                                u.getFirstName().toLowerCase().contains(term) ||
                                u.getLastName().toLowerCase().contains(term)  ||
                                u.getUsername().toLowerCase().contains(term)
                        )
                        .collect(Collectors.toCollection(ArrayList::new));
            }

            // ── Sort ─────────────────────────────────────
            String sort  = request.getParameter("sort");
            String order = request.getParameter("order");

            Comparator<User> comparator;

            if      ("firstName".equals(sort)) comparator = Comparator.comparing(User::getFirstName, String.CASE_INSENSITIVE_ORDER);
            else if ("lastName".equals(sort))  comparator = Comparator.comparing(User::getLastName,  String.CASE_INSENSITIVE_ORDER);
            else if ("username".equals(sort))  comparator = Comparator.comparing(User::getUsername,  String.CASE_INSENSITIVE_ORDER);
            else                               comparator = Comparator.comparing(User::getId);

            if ("desc".equals(order)) comparator = comparator.reversed();

            users.sort(comparator);

            // ── Pagination ───────────────────────────────
            int totalUsers = users.size();
            int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            int currentPage;
            try
            {
                currentPage = Integer.parseInt(request.getParameter("page"));
                if (currentPage < 1)           currentPage = 1;
                if (currentPage > totalPages)  currentPage = totalPages;
            }
            catch (NumberFormatException e)
            {
                currentPage = 1;
            }

            int fromIndex = (currentPage - 1) * PAGE_SIZE;
            int toIndex   = Math.min(fromIndex + PAGE_SIZE, totalUsers);

            ArrayList<User> pagedUsers = new ArrayList<>(users.subList(fromIndex, toIndex));

            // ── Forward to view ──────────────────────────
            request.setAttribute("users",       pagedUsers);
            request.setAttribute("totalPages",  totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalUsers",  totalUsers);

            request.getRequestDispatcher(LIST_VIEW).forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("error", "Could not load users.");
            request.getRequestDispatcher(LIST_VIEW).forward(request, response);
        }
    }
}