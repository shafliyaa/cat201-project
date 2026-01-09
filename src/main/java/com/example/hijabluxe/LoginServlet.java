package com.example.hijabluxe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // All statements go **inside doPost**
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(username, username+"@email.com", password, "123 Main St", "0123456789");

        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        response.sendRedirect("products.jsp"); // redirect after login
    }
}
