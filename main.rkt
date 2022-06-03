#lang racket/base
(require slideshow/base pict)
(provide mkDiagram current-aspect mkOutline mkCover mkSection ct)

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
     #:title title #:layout layout #:aspect (current-aspect)
     (if line (hline (current-para-width) (current-gap-size)) 'nothing)
     (apply item items))))

(define mkCover
  (lambda (#:title title #:line [line #t] #:layout [layout 'center] #:info info)
    (slide #:layout layout #:aspect (current-aspect)
           title
           (if line (hline (current-para-width) (current-gap-size)) 'nothing)
           info)))

(define mkSection
  (lambda (#:index index #:title title #:layout [layout 'center])
    (slide #:layout layout #:aspect (current-aspect) index title)))

(define ct
  (lambda (content [style 'roman] [size (current-font-size)] [color #f])
    (let ((pict (text content style size)))
      (if color (colorize pict color) pict))))