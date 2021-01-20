;;; Scheme Recursive Art Contest Entry
;;;
;;; Please do not include your name or personal info in this file.
;;;
;;; Title: A 2D Projection of a 3D Rotated Spring
;;;
;;; Description:
;;;   <Our lives oscillate
;;;    like a coiled spring consuming 
;;;    itself. Amazing.>
(define pi 3.1415926535897)

(define (create-x1 l r w phi)
  (lambda (n) (+ 
              (/ 
                (* r (cos (* w n)))
                (sqrt (+ 
                        (* (cos (* w n)) (cos (* w n))) 
                        (* (sin (* w n)) (sin (* w n)))
                      )
                )
              ) 

              (* l (cos (+ 
                      n
                      phi))))))

(define x1 (create-x1 150 90 7.1 (/ pi 100)))

(define (create-y1 l r w phi)
  (lambda (n) (+ (/ (* r (sin (* w n)))
                (sqrt (+ (* 
                          (cos (* w n)) 
                          (cos (* w n))) 
                          (* (sin (* w n)) (sin (* w n)))
                      )
                )
                )
            (* l (sin (+ n phi))))))

(define y1 (create-y1 150 90 7.1 (/ pi 100)))

(define (z1 n)
  (* 90 (cos (* 7.1 n))))





(define (x1 n)
  (+ (* (cos (+ n (/ pi 50))) 150)  (* (* (/ 90 (+ (/ (* n n) 50) 1)) (cos (* 7 n))) (cos n))))

;(define x1 (create-x1 150 90 7.1 (/ pi 50)))

(define (y1 n)
  (+ (* (sin (+ n (/ pi 50))) 150)  (* (* (/ 90 (+ (/ (* n n) 50) 1)) (cos (* 7 n))) (sin n))))

(define (z1 n)
  (* (/ 90 (+ (/ (* n n) 50) 1)) (sin (* 7 n))))

(define (min a b)
  (if (< a b) a b))

(define (max a b)
  (if (> a b) a b))


(define (x-create l r w phi)
  (lambda (n) (+ (* (cos (+ n phi)) l)  (* (* (/ r (+ (/ (* n n) 50) 1)) (cos (* w n))) (cos n)))))

(define x1 (x-create 200 30 7 (/ pi 12)))

(define x2 (x-create 200 30 7 0))

(define x3 (x-create 200 30 7 (/ pi 24)))

(define x4 (x-create 200 30 7 (/ pi 48)))

(define x5 (x-create 200 30 7 (/ pi 16)))

(define (y-create l r w phi)
  (lambda (n) (+ (* (sin (+ n phi)) l)  (* (* (/ r (+ (/ (* n n) 50) 1)) (cos (* w n))) (sin n)))))

(define y1 (y-create 200 30 7 (/ pi 12)))

(define y2 (y-create 200 30 7 0))

(define y3 (y-create 200 30 7 (/ pi 24)))

(define y4 (y-create 200 30 7 (/ pi 48)))

(define y5 (y-create 200 30 7 (/ pi 16)))

;(define (y2 n)
;  (* (+ 150 (* (/ 90 (+ (/ (* n n) 50) 1)) (cos (* 7 n)))) (sin n)))

(define (z2 n)
  (* (/ 90 (+ (/ (* n n) 50) 1)) (sin (* 7 n))))



(define (x-prime x y theta)
  (lambda (n) (+ (* (y n) (cos theta))(x n))))

(define (y-prime y z theta)
  (lambda (n) (+ (* (y n) (sin theta))(z n))))

(define (x-axes-x n)
  n)

(define (x-axes-y n)
  0)

(define (x-axes-z n)
  0
  )

(define (y-axes-x n)
  0)

(define (y-axes-y n)
  n)

(define (y-axes-z n)
  0
  )

(define (shift-fn fn amount)
  (lambda (n) (+ (fn n) amount)))  

(define (graph-parametric x y start end step)
  (if (not (>= start end))
    (graph-point x y (+ start step) end step)))

(define (graph-point x y curr end step)
  (color (rgb (max 0 (min 1 (+ .5 (cos (* pi (* 2 (/ curr end))))))) (max 0 (min 1 (+ .5 (cos (* pi(* 2 (+ (/ 2 3) (/ curr end)))))))) (max 0 (min 1 (+ .5 (cos (* pi(* 2 (+ (/ 1 3) (/ curr end))))))))))
  (setposition (x curr) (y curr))
  (pendown)
  ;(pendown)
  ;(circle 1 360)
  ;(dot 3)
  ;(penup)
  (graph-parametric x y curr end step))

(define (graph-parametric-jump x y start end step jump-size)
  (if (not (>= start end))
    (graph-point-jump x y (+ start (* jump-size step)) end step jump-size)))

(define (graph-point-jump x y curr end step jump-size)
  (color (rgb (max 0 (min 1 (+ .5 (cos (* pi (* 2 (/ curr end))))))) (max 0 (min 1 (+ .5 (cos (* pi(* 2 (+ (/ 2 3) (/ curr end)))))))) (max 0 (min 1 (+ .5 (cos (* pi(* 2 (+ (/ 1 3) (/ curr end))))))))))
  
  (setposition (x curr) (y curr))
  (pendown)
  (setposition (x (+ curr step)) (y (+ curr step)))
  (penup)
  ;(pendown)
  ;(circle 1 360)
  ;(dot 3)
  ;(penup)
  (graph-parametric-jump x y (+ curr step) end step jump-size))

(define (graph-parametric-simul x1 y1 x2 y2 start end step)
  (if (not (>= start end))
    (graph-point-simul x1 y1 x2 y2 (+ start step) end step)))

(define (graph-point-simul x1 y1 x2 y2 curr end step)
  (color (rgb (max 0 (min 1 (+ .5 (cos (* pi (* 2 (/ curr end))))))) (max 0 (min 1 (+ .5 (cos (* pi(* 2 (+ (/ 2 3) (/ curr end)))))))) (max 0 (min 1 (+ .5 (cos (* pi(* 2 (+ (/ 1 3) (/ curr end))))))))))
  (penup)
  (setposition (x1 curr) (y1 curr))
  (pendown)
  (setposition (x2 curr) (y2 curr))
  (graph-parametric-simul x1 y1 x2 y2 curr end step))

(define (draw)
  (speed 0)
  (penup)
  (setposition -200 -150)
  (setheading 0)
  ;(graph-parametric x1 y1 0 6.28 .01)
  (define x1-2d (x-prime x1 y1 (/ pi 6)))
  (define y1-2d (y-prime y1 z1 (/ pi 6)))

  (define x2-2d (x-prime x2 y2 (/ pi 6)))
  (define y2-2d (y-prime y2 z1 (/ pi 6)))

  (define x3-2d (x-prime x3 y3 (/ pi 6)))
  (define y3-2d (y-prime y3 z1 (/ pi 6)))

  (define x4-2d (x-prime x4 y4 (/ pi 6)))
  (define y4-2d (y-prime y4 z1 (/ pi 6)))

  (define x5-2d (x-prime x5 y5 (/ pi 6)))
  (define y5-2d (y-prime y5 z1 (/ pi 6)))
  ;(define x-axes-y-2d (x-prime x-axes-x x-axes-y (/ pi35897 6)))
  ;(define x-axes-y-2d (y-prime x-axes-x x-axes-y (/ pi35897 6)))

  ;(color (rgb 1 0 0))
  (penup)
  (graph-parametric-simul x1-2d y1-2d x2-2d y2-2d 0 (* (/ 5 2) pi) .01)
  (penup)
  (graph-parametric x1-2d y1-2d 0 (* (/ 5 2) pi) .01)
  (penup)
  (graph-parametric x2-2d y2-2d 0 (* (/ 5 2) pi) .01)
  (penup)
  (graph-parametric-jump x3-2d y3-2d 0 (* (/ 5 2) pi) .01 2)
  (penup)
  (graph-parametric-jump x4-2d y4-2d .01 (* (/ 5 2) pi) .01 2)
  (penup)
  (graph-parametric-jump x5-2d y5-2d .01 (* (/ 5 2) pi) .01 2)
  ;(graph-parametric-simul x1-2d y1-2d x2-2d y2-2d 0 6.28 .01)
  (penup)
  ;(graph-parametric x-axes-x x-axes-y -400 400 5)
  (penup)
  ;(graph-parametric y-axes-x y-axes-y -400 400 5)
  (exitonclick))

; Please leave this last line alone.  You may add additional procedures above
; this line.
(draw)