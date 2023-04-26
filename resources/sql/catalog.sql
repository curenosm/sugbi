-- :name insert-book! :! :1
insert into catalog.book (title, isbn)
values (:title, :isbn) returning *;

-- :name delete-book! :! :n
delete
from catalog.book
where isbn = :isbn;

-- :name search :? :*
select b.isbn as "isbn", available(b.isbn) as "available"
from catalog.book b
where lower(b.title) like :title;

-- :name get-book :? :1
select b.isbn as "isbn", available(b.isbn) as "available"
from catalog.book b
where b.isbn = :isbn;

-- :name get-books :? :*
select b.isbn as "isbn", available(b.isbn) as "available"
from catalog.book b;

-- :name checkout-book :! :*
insert into catalog.lendings (book_id, user_id, book_item_id, lending_start)
values (:book-id,
        :user-id,
        :book-item-id,
        now());

-- :name return-book :! :*
update catalog.lendings
set lending_end = now()
where user_id = :user-id
  and book_item_id = :book-item-id;

-- :name get-book-lendings :? :1
select *
from catalog.lendings
where user_id = :user-id;