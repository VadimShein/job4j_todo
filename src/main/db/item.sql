create table item (
                      id serial primary key,
                      description varchar not null,
                      created timestamp not null,
                      done boolean
)