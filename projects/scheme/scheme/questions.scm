(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.
(define (map proc items)
    (if (null? items) '()
    (cons (proc (car items)) (map proc (cdr items)))))

(define (cons-all first rests)
  (cond
    ((null? rests) nil)
    (else (cons (cons first (car rests)) (cons-all first (cdr rests)))))
  )

(define (zip pairs)
  (list (map (lambda (pair) (car pair)) pairs) (map (lambda (pair) (car (cdr pair))) pairs))
   )

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (enumerate-index s 0)
  )
  ; END PROBLEM 17

(define (enumerate-index s index)
  (cond
    ((null? s) nil)
    (else (cons (cons index (cons (car s) nil)) (enumerate-index (cdr s) (+ index 1))))
    )
  )

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
;; Our helper funtion "repeat" for Problem 18
(define (repeat n x)
  (if (= n 0)
    '()
    (cons x (repeat (- n 1) x))))

(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (cond
    ((= 0 total) '(()))
    ((null? (cdr denoms)) (list (repeat total (car denoms))))
    ((> (car denoms) total) (list-change total (cdr denoms)))
    (else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms)) (list-change total (cdr denoms)))))
  )
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons (cons (quote lambda) 
                       (cons (car (zip (let-to-lambda values))) 
                             (let-to-lambda body))) 
                 (cadr (zip (let-to-lambda values))))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
