;; 逆ポーランド記法電卓 (関数型スタイル2)

(ns rpn-calculator2
  (:require [clojure.string :refer [split]]))

(declare ope-fn)

(def ^:private operators
  {"+" +
   "-" -
   "*" *
   "/" /})

(defn calculate [rpn]
  (let [calc (fn [stack x]
               (if (every? #(Character/isDigit %) x)
                 (cons (Double/parseDouble x) stack)
                 (let [[y1 y2 & ys] stack]
                   (cons ((ope-fn x) y2 y1) ys))))
        expr (split rpn #"\s+")]
    (first (reduce calc () expr))))

(defn- ope-fn [ope]
  (if (contains? operators ope)
    (operators ope)
    (throw (UnsupportedOperationException.
      (format "unsupported operator '%s' is used" ope)))))

;; 利用例
(let [rpn "1 2 + 3 / 4 - 5 *"]
  (printf "%s%n = %s%n" rpn (calculate rpn)))
