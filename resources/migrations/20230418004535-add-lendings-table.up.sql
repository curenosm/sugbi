create table catalog.lendings
(
    lending_id    bigint generated always as identity,
    isbn          bigint not null,
    user_id       bigint,
    lending_start timestamp,
    lending_end   timestamp,
    primary key (lending_id),
    constraint fk_book_items
        foreign key (book_items)
        references book_items(book_item_id)
);