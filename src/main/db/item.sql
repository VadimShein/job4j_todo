create table item (
    id serial primary key,
    description varchar not null,
    created timestamp not null,
    done boolean,
    user_id int not null references users(id)
)