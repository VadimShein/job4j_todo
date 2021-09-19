package ru.job4j.todo.servlet;

import org.json.JSONObject;
import ru.job4j.todo.model.Category;
import ru.job4j.todo.model.Item;
import ru.job4j.todo.model.User;
import ru.job4j.todo.store.PsqlStore;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.List;

public class TaskServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");

        List<Item> items;
        if ("true".equals(req.getParameter("allTasks"))) {
            items = PsqlStore.instOf().getTasks(Integer.parseInt(req.getParameter("userId")));
        } else {
            items = PsqlStore.instOf().getCurrentTasks(Integer.parseInt(req.getParameter("userId")));
        }
        List<Category> categories = PsqlStore.instOf().getAllCategories();

        JSONObject jsonObj = new JSONObject();
        jsonObj.put("tasks", items);
        jsonObj.put("categories", categories);
        PrintWriter writer = new PrintWriter(resp.getOutputStream(), true, StandardCharsets.UTF_8);
        writer.println(jsonObj.toString());
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        if ("add".equals(req.getParameter("action"))) {
            Item item = new Item(
                    req.getParameter("desc"),
                    new Date(System.currentTimeMillis()),
                    false,
                    (User) req.getSession().getAttribute("user"));
            String[] categories = req.getParameterValues("cIds");
            for (String cat : categories) {
                item.addCategory(PsqlStore.instOf().findCategoryById(Integer.parseInt(cat)));
            }
            PsqlStore.instOf().addTask(item);
        }
        if ("update".equals(req.getParameter("action"))) {
            Item item = PsqlStore.instOf().findTaskById(Integer.parseInt(req.getParameter("taskId")));
            item.setDone(!Boolean.parseBoolean(req.getParameter("done")));
            PsqlStore.instOf().updateTask(item);
        }
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}
