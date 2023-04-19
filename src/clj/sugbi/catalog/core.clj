(ns sugbi.catalog.core
 (:require
  [clojure.set :as set]
  [sugbi.catalog.db :as db]
  [sugbi.catalog.open-library-books :as olb]))


(defn merge-on-key
  [k x y]
  (->> (concat x y)
       (group-by k)
       (map val)
       (map (fn [[x y]] (merge x y)))))


(def available-fields olb/relevant-fields)

;; Se decidió que la lógica para determinar si un libro está disponible para
;; prestamos, será delegada a clojure, pensando en el uso de la tabla lendings
;; y verificando el total de ejemplares en el stock 
(defn is-available-for-lending
  [isbn]
  {:available  (db/get-book {:isbn isbn})})


(defn get-book
  [isbn fields]
  (if-let [db-book (db/get-book {:isbn isbn})]
    (let [open-library-book-info (olb/book-info isbn fields)]
      (merge db-book open-library-book-info))
    {}))


(defn get-books
  [fields]
  (let [db-books                (db/get-books {})
        isbns                   (map :isbn db-books)
        open-library-book-infos (olb/multiple-book-info isbns fields)]
    (merge-on-key
     :isbn
     db-books
     open-library-book-infos)))


(defn enriched-search-books-by-title
  [title fields]
  (let [db-book-infos           (db/matching-books title)
        isbns                   (map :isbn db-book-infos)
        open-library-book-infos (olb/multiple-book-info isbns fields)]
    (merge-on-key
     :isbn
     db-book-infos
     open-library-book-infos)))
