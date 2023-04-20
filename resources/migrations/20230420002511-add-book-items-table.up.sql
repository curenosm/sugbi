alter table catalog.lendings add book_item_id int not null;
--;;
create table catalog.book_items (
    book_item_id bigint generated always as identity primary key,
    book_id int not null,
    available boolean not null
);