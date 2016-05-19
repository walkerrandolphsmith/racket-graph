#lang plai
(define mygraph
     '{{a {b c d}}
       {b {a e}}
       {c {a e f}}
       {d {a f}}
       {e {b c g}}
       {f {c d g}}
       {g {e f}} 
       {h {i j}}
       {i {h j}}
       {j {h i}}})

(define (postvisit v visited)
(begin
  (print v)
  visited))

;; degree :  symbol, graph --> int
;; returns the degree of v in "graph"
(define (degree v graph)
  (cond
    ((equal? v (caar graph))(length (cadar graph)))
    (else (degree v (cdr graph)))))

(test (degree 'c mygraph) 3) 

;; vertices : list (graph) --> list (vertices)
;; given a graph the function returns a list of vertices in the graph
(define (vertices graph)
  (cond
    ((null? graph) '())
    ( else   (cons (first (first graph)) (vertices (rest graph))))))
(test (vertices mygraph) '(a b c d e f g h i j))
(test (vertices '()) '())

;; sameEdge? : list (edge), list (edge) --> boolean
;; returns true if the two edges are equivalent, otherwise false
(define (sameEdge? e1 e2)
  (cond 
    ((and(equal? (car e1) (car e2))(equal? (cdr e1) (cdr e2))) #t)
    ((and(equal? (car e1) (cadr e2))(equal? (cadr e1) (car e2))) #t)
    (else #f)))

(test (sameEdge? '(a b) '(a b)) #t)
(test (sameEdge? '(a b) '(b a)) #t)
(test (sameEdge? '(a c) '(a d)) #f)

;; edgeMember? : list (edge), list (list of edges) --> boolean
;; returns true if the edge is in the list, otherwise false
(define (edgeMember? edge edgelist)
  (cond 
    ((empty? edgelist) #f)
    ((sameEdge? edge (car edgelist)) #t)
    (else (edgeMember? edge (cdr edgelist)))))

(test (edgeMember? '(a b) '((a c)(a d)(b e) (b a) (c d))) #t)
(test (edgeMember? '(a b) '((a c)(a d)(b e) (c d))) #f)


;; makeEdges : symbol (vertex), list (vertex list) --> list (edges)
;; makes a collection of all the edges with "vertex" as one vertex and a member
;; of "lis" as the second element in an edge
(define (makeEdges vertex lis)
  (cond 
    ((empty? lis)'())
    ((< 0 (length lis))(cons (list vertex (car lis))(makeEdges vertex (cdr lis))))))
    

(test (makeEdges 'a '(b c d e)) '((a b) (a c) (a d) (a e)))

;; removeDupEdges : list --> list
;; is passed a list of edges and it returns the list of edges
;; with the duplicate edges removed
(define (removeDupEdges lis)
  (cond
    ((empty? lis) '())
    ((edgeMember? (car lis) (cdr lis)) (removeDupEdges (cdr lis)))
    (else (cons (car lis) (removeDupEdges (cdr lis))))
    ))

(test (removeDupEdges '((a b)(b c)(c d) (c d) (d c) (e f)))  '((a b) (b c) (d c) (e f)))
(test (removeDupEdges '((a b)(b a)(c d)(d c))) '((b a)(d c)))

;; edges : list (graph) --> list 
;; given a graph, the function returns a list of edges in the graph

(define (edges graph)
 (cond
   ((empty? graph) '())
   (else (removeDupEdges (append (makeEdges (caar graph) (cadar graph)) (edges (cdr graph)))))))

(test (edges mygraph) '((b a)(c a)(d a)(e b)(e c)(f c)(f d)(g e)(g f)(i h)(j h)(j i)) )

;; vertexMember? : symbol, List --> boolean
;; detemines if the symbol is in the list, if so, it returns true,
;; otherwise it returns false
(define (vertexMember? v group)
  (cond
    ((empty? group) #f)
    ((equal? v (car group)) #t)
    (else (vertexMember? v (cdr group)))))

(test (vertexMember? 'a '(a b c d e f)) #t)
(test (vertexMember? 'a '(b c d e a f)) #t)
(test (vertexMember? 'z '(b c d e f)) #f)


;; adjacentVertices :  symbol, graph --> list
;; returns the list of adjacent vertices
(define (adjacentVertices v graph)
  (cond
    ((empty? graph) '{})
     ((equal? v (first (first graph))) (cadar graph))
     (else (adjacentVertices v (rest graph)))))

(test (adjacentVertices 'a mygraph) '(b c d))
