(define (find s predicate)
  (cond
  	((null? s) #f)
  	((predicate (car s)) (car s))
  	(else (find (cdr-stream s) predicate)))
)

(define (scale-stream s k)
  (cond
  	((null? s) nil)
  	(else (cons-stream (* k (car s)) (scale-stream (cdr-stream s) k))))
)

(define (has-cycle-helper s original)
  (cond
 	((null? s) #f)
  	((eq? s original) #t)
  	(else (has-cycle-helper (cdr-stream s) original))
  )
)

(define (has-cycle s)
  (has-cycle-helper (cdr-stream s) s)
)

(define (has-cycle-constant s)
  'YOUR-CODE-HERE
)
