package ru.job4j.todo.servlet;

import ru.job4j.todo.model.Item;
import ru.job4j.todo.model.User;
import ru.job4j.todo.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class RegServlet  extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User findUser =  PsqlStore.instOf().findByEmailUser(email);
        if (findUser == null) {
            HttpSession sc = req.getSession();
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            System.out.println("EMAIL " + email);
            user.setPassword(password);
            sc.setAttribute("user", user);
            PsqlStore.instOf().createUser(user);
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            req.setAttribute("error", "email уже был использован");
            req.getRequestDispatcher("reg.jsp").forward(req, resp);
        }
    }
}
