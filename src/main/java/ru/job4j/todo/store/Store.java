package ru.job4j.todo.store;

import ru.job4j.todo.model.Item;

import java.util.List;

public interface Store {
    List<Item> getTasks();
    List<Item> getCurrentTasks();
    void addTask(Item item);
}
