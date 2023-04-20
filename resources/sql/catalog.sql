-- :name insert-book! :! :1
insert into catalog.book (title, isbn) values (:title, :isbn)
returning *;

-- :name delete-book! :! :n
delete from catalog.book where isbn = :isbn;

-- :name search :? :*
select b.isbn as "isbn", bi.available as "available"
from catalog.book b 
inner join catalog.book_items bi
on b.book_id = bi.book_id
where lower(b.title) like :title;

-- :name get-book :? :1
select b.isbn as "isbn", bi.available as "available"
from catalog.book b
inner join catalog.book_items bi
on b.book_id = bi.book_id
where b.isbn = :isbn;

-- :name get-books :? :*
select b.isbn as "isbn", bi.available as "available"
from catalog.book b
inner join catalog.book_items bi
on b.book_id = bi.book_id;


-- :name checkout-book :! :*
insert into catalog.lendings (book_id, user_id, lending_start) values (
    :book-id,
    :user-id,
    :book-item-id,
    now());

update catalog.book_items
set available = false
where book_item_id = :book-item-id;
--;;

-- :name return-book :! :*
update catalog.lendings
set lending_end = now()
where user_id = :user-id and book_item_id = :book-item-id;

update catalog.book_items
set available = true
where book_item_id = :book-item-id;
--;;

-- :name get-book-lendings :? :1
select * from catalog.lendings where user_id = :user-id;
