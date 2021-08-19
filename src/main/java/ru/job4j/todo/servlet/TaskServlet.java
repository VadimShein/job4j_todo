package ru.job4j.todo.servlet;

import org.json.JSONObject;
import ru.job4j.todo.model.Item;
import ru.job4j.todo.model.User;
import ru.job4j.todo.store.PsqlStore;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.util.List;


public class TaskServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");

        if (req.getParameter("taskId") != null) {
            PsqlStore.instOf().updateTask(Integer.parseInt(req.getParameter("taskId")));
        }
        List<Item> items;
        if ("true".equals(req.getParameter("allTasks"))) {
            items = PsqlStore.instOf().getTasks(Integer.parseInt(req.getParameter("userId")));
        } else {
            items = PsqlStore.instOf().getCurrentTasks(Integer.parseInt(req.getParameter("userId")));
        }

        JSONObject jsonObj = new JSONObject();
        jsonObj.put("tasks", items);
        PrintWriter writer = new PrintWriter(resp.getOutputStream(), true, StandardCharsets.UTF_8);
        writer.println(jsonObj.toString());
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        User user;
        if (req.getParameter("userEmail") != null) {
            user = PsqlStore.instOf().findByEmailUser(req.getParameter("userEmail"));
            Item item = new Item(
                    req.getParameter("desc"),
                    new Timestamp(System.currentTimeMillis()),
                    false,
                    user);
            PsqlStore.instOf().addTask(item);
        }
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}
