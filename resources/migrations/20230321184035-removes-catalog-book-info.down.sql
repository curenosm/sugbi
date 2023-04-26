alter table catalog.book
    drop column isbn;
--;;
create table catalog.author
(
    author_id bigint generated always as identity primary key,
    full_name text not null unique
);
--;;
create table catalog.book_author
(
    author_id bigint not null references catalog.author,
    book_id   bigint not null references catalog.book
);
