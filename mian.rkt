#lang racket/base
(require slideshow/base pict)
(provide mkDiagram)

(define mkDiagram
  (lambda (#:title [title #f] #:aspect [aspect #f] #:layout [layout 'auto] #:para [para #f] #:line [line #t] #:pict pict #:reference reference)
    (slide #:title title #:aspect aspect #:layout layout
           (if para para 'nothing)
           (if line (hline (current-para-width) (current-gap-size)) 'nothing)
           pict
           reference)))