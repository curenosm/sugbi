drop table catalog.book_author;
--;;
drop table catalog.author;
--;;
alter table catalog.book
    add isbn text not null unique;
