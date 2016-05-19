# Racket Graph

## Degree 
`symbol, graph --> int`  
Return the degree of vertex v in graph G

## Vertices
`list (graph) --> list (vertices)`  
Return a list of vertices in the graph G

## SameEdge?
`list (edge), list (edge) --> boolean`  
Return true if two edges are equivalent

## EdgeMember?
`list (edge), list (list of edges) --> boolean`  
Return true if the edge is in the list

## makeEdges
`symbol (vertex), list (vertex list) --> list (edges)`  
Makes a collection of all the edges with `vertex` as one vertex and a member of `lis` as the second element in an edge.

## removeDupEdges
`list --> list`  
Returns a list of edges that does not have more than one instance of any edge in the list provided.

## Edges 
`list (graph) --> list`  
Returns a list of edges in the graph G

## VertexMember?
`symbol, list --> boolean`  
Return true if the symbol is in the list

## AdjacentVertices 
`symbol, graph --> list`  
Return list of adjacent vertices 
