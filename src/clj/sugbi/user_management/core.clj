(ns sugbi.user-management.core
  (:require
    [sugbi.user-management.db :as db]))


(defn is-librarian?
  [sub]
  (boolean
    (db/get-librarian {:sub sub})))


(defn insert-librarian
  [sub]
  (db/insert-librarian! {:sub sub}))
