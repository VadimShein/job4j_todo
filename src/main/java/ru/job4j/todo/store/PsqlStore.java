package ru.job4j.todo.store;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.todo.model.Item;

import java.util.List;
import java.util.function.Function;

public class PsqlStore implements Store, AutoCloseable {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
    private final SessionFactory sf = new MetadataSources(registry).buildMetadata().buildSessionFactory();

    private static final class Lazy {
        private static final Store INST = new PsqlStore();
    }

    public static Store instOf() {
        return Lazy.INST;
    }

    private <T> T tx(final Function<Session, T> command) {
        final Session session = sf.openSession();
        try (session) {
            final Transaction tx = session.beginTransaction();
            T rsl = command.apply(session);
            tx.commit();
            return rsl;
        } catch (final Exception e) {
            session.getTransaction().rollback();
            throw e;
        }
    }

    @Override
    public void close() {
        StandardServiceRegistryBuilder.destroy(registry);
    }

    @Override
    public List<Item> getTasks() {
        return this.tx(
                session -> session.createQuery("from ru.job4j.todo.model.Item").list()
        );
    }

    @Override
    public List<Item> getCurrentTasks() {
        return this.tx(
                session -> session.createQuery("from ru.job4j.todo.model.Item where done = false").list()
        );
    }

    @Override
    public void addTask(Item item) {
        this.tx(
                session -> session.save(item)
        );
    }

    @Override
    public void updateTask(int id) {
        this.tx(
                session -> {
                    Item item = session.get(Item.class, id);
                    item.setDone(true);
                    session.update(item);
                    return item;
                }
        );
    }
}
