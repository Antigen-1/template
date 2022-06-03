#lang racket/base
(require slideshow/base pict)
(provide mkDiagram current-aspect mkOutline)

(define current-aspect (make-parameter #f))

(define mkDiagram
  (lambda (#:title [title #f] #:layout [layout 'auto] #:para [para #f] #:line [line #t] #:pict pict #:reference reference)
    (slide #:title title #:aspect (current-aspect) #:layout layout
           (if para para 'nothing)
           (if line (hline (current-para-width) (current-gap-size)) 'nothing)
           pict
           reference)))

(define mkOutline
  (lambda (#:title [title #f] #:layout [layout 'auto] #:line [line #t] . items)
    (slide
     #:title title #:layout layout
     (if line (hline (current-para-width) (current-gap-size)) 'nothing)
     (apply item items))))