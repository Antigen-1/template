#lang racket/base

(module base racket/base
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
        (if color (colorize pict color) pict)))))

(module mind-map racket/base
  (require pict racket/function)
  (provide mkElement mkLine mkConstructor)

  (define mkElement
    (lambda (#:border-color [color "firebrick"] #:pict pict #:scale [s 5] #:line-width [lw 1])
      (explain pict #:border color #:baseline #f #:ascent #f #:scale s #:line-width lw)))
  (define mkLine
    (lambda (#:pict pict #:src src #:dest dest #:src-finder src-finder #:dest-finder dest-finder #:constructor constructor)
      (constructor pict src src-finder dest dest-finder)))
  (define mkConstructor
    (lambda (#:procedure procedure #:style [style #f] #:under? [under? #f] #:label [label (blank)] #:start-angle [start-angle #f]
             #:end-angle [end-angle #f] #:start-pull [start-pull 1/4] #:end-pull [end-pull 1/4]	#:line-width [line-width #f]
             #:color [color #f] . other)
      (apply (curry procedure)
             #:style style #:under? under? #:label label #:start-angle start-angle
             #:end-angle end-angle #:start-pull start-pull #:end-pull end-pull	#:line-width line-width
             #:color color other))))