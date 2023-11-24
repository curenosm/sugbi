(ns sugbi.db.core-test
    (:require
      [sugbi.db.core :refer [*db*]
       :as                  db]
      [java-time.pre-java8]
      [luminus-migrations.core :as migrations]
      [clojure.test :refer :all]
      [next.jdbc :as jdbc]
      [sugbi.config :refer [env]]
      [mount.core :as mount]))

(use-fixtures :once
 (fn [f]
   (mount/start #'sugbi.config/env #'sugbi.db.core/*db*)
   (migrations/migrate ["migrate"] (select-keys env [:database-url]))
   (f)))
