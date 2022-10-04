create table if not exists users(
    id serial primary key,
    name varchar not null,
    email varchar unique not null,
    password varchar not null
);

create table if not exists item(
    id serial primary key,
    description varchar not null,
    created timestamp not null,
    done boolean,
    user_id int references users(id)
);

create table if not exists item_categories(
    item_id int references item(id),
    categories_id int references categories(id)
);

create table if not exists categories(
    id serial primary key,
    name varchar not null
);