create table catalog.book_items
(
    book_item_id bigint generated always as identity,
    isbn         int      not null,
    primary key (book_item_id)
);