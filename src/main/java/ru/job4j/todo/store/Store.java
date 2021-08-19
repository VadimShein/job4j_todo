package ru.job4j.todo.store;

import ru.job4j.todo.model.Item;
import ru.job4j.todo.model.User;

import java.util.List;

public interface Store {
    List<Item> getTasks(int userId);
    List<Item> getCurrentTasks(int userId);
    void addTask(Item item);
    void updateTask(int id);
    void createUser(User user);
    User findByEmailUser(String email);
}
