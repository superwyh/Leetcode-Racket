(define/contract (get-permutation n k)
  (-> exact-integer? exact-integer? string?)

  (define (calculate-factorials n)
    (let loop ([i 1] [acc '(1)])
      (if (> i n) (reverse acc)
          (loop (add1 i) (cons (* i (car acc)) acc)))))
  
  (define factorial (calculate-factorials n))
  (set! k (sub1 k))
  (define ans '())
  (define valid (make-vector (add1 n) 1))
  
  (for ((i (in-range 1 (add1 n))))
    (define order (add1 (quotient k (list-ref factorial (- n i)))))
    (define found #f)
    (for ((j (in-range 1 (add1 n))) #:break found)
      (set! order (- order (vector-ref valid j)))
      (when (= order 0)
        (set! ans (cons (number->string j) ans))
        (vector-set! valid j 0)
        (set! found #t)))
    (set! k (remainder k (list-ref factorial (- n i)))))

  (apply string-append (reverse ans)))