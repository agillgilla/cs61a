;;; Scheme Recursive Art Contest Entry
;;;
;;; Please do not include your name or personal info in this file.
;;;
;;; Title: <Your title here>
;;;
;;; Description:
;;;   <It's your masterpiece.
;;;    Use these three lines to describe
;;;    its inner meaning.>
(define (draw-sprout depth)
  (if (eq? depth 0) (exitonclick)
  (pendown))
  (speed 10)
  (draw-growth 5))

(define (draw-growth width direction)
  (if (> width .2) (draw-growth-helper width direction)
  ))

(define (draw-growth-helper width direction)
  (pendown)
  (speed 10)
  (pensize width)
  (fd (* 2 width))
  (direction 10)
  (draw-growth (- width .2) direction))

(define (draw)
  (penup)
  (setposition -200 -150)
  (draw-growth 10 lt)
  (penup)
  (setheading 0)
  (setposition -200 -150)
  (draw-growth 10 rt)
  (exitonclick))

; Please leave this last line alone.  You may add additional procedures above
; this line.
(draw)