#lang racket
(require "utilities.rkt")
(require "interp.rkt")

(provide r1-passes) 

(define (uniquify alist) 
  (lambda (e) 
      (match e
        [(? symbol?) e]
        [(? integer?) e]
        ['(let ([,x ,e]) ,body)(e )]
        ['(program ,e)
         '(program ,((uniquify alist) e))]
        ['(,op ,es ...) 
         '(op ,(map(uniquify alist) es))]
        )))

;;(define (flatten 



(define r1-passes `(("uniquify" ,uniquify ,interp-scheme)
                    ("flatten" ,flatten ,interp-C)
                    ("select instructions" ,select-instructions ,interp-x86)
                    ("assign homes" ,assign-homes ,interp-x86)
                    ("patch instructions" ,patch-instructions ,interp-x86)
                    ("print x86" ,print-x86 #f)))