## Put comments here that give an overall description of what your
## functions do

## This function creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
  #Initially set matrix inverse to null
  i<-NULL
  set<-function(y){
    x<<-y
  }
  get<-function() x
  setInverse<-function(inv){
    i<<-inv
  }
  getInverse<function() i
}


## This function computes the inverse of the special "matrix" returned by 
# makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), 
#then cacheSolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  #check if inverse already exists
  i<x$getInverse()
  if(!is.null(i))
  {
    message("getting inverse from cache")
    return(i)
  }
  mat<-x$get()
  i<-solve(mat)
  x$setInverse(i)
  i
}
