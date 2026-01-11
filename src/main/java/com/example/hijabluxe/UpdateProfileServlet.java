package com.example.hijabluxe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UpdateProfileServlet", value = "/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the new name from the form
        String newName = request.getParameter("updated_username");

        // 2. Get the current user from the session
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser != null && newName != null && !newName.trim().isEmpty()) {
            // 3. Update the User object
            currentUser.setUsername(newName);

            // 4. Update the session (Optional but good practice)
            session.setAttribute("currentUser", currentUser);
        }

        // 5. Send the user back to the profile page
        response.sendRedirect("main.jsp?view=profile");
    }
}