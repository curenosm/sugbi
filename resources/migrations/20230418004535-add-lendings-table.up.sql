create table catalog.lendings (
    lending_id bigint generated always as identity primary key,
    book_id bigint,
    user_id bigint,
    lending_start date,
    lending_end date
);