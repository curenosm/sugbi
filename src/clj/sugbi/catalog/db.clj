(ns sugbi.catalog.db
  (:require
    [camel-snake-kebab.core :as csk]
    [clojure.string :as str]
    [conman.core :as conman]
    [sugbi.db.core :as db]
    [medley.core :as medley]))

(conman/bind-connection db/*db* "sql/catalog.sql")


(defn matching-books
  [title]
  (map
   #(medley/map-keys csk/->kebab-case %)
   (search {:title (str "%" (str/lower-case title) "%")})))
