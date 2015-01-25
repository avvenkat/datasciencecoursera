# Coursera Data Science R Programming - Week 3 assignment
# Matrix inversion is usually a costly computation and there may be some benefit to 
# caching the inverse of a matrix rather than computing it repeatedly 
# makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
        inver <- NULL
        set <- function(y) {
                x <<- y
                inver <<- NULL
        }
        get <- function() x
        setinverse <- function(inverse) inver <<- inverse
        getinverse <- function() inver
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


# cacheSolve: This function computes the inverse of the special "matrix" 
# returned by makeCacheMatrix above. If the inverse has already been
# calculated (and the matrix has not changed), then cacheSolve should
# retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        inver <- x$getinverse()
        if(!is.null(inver)) {
                message("getting cached data")
                return(inver)
        }
        data <- x$get()
        inver <- solve(data, ...)
        x$setinverse(inver)
        inver
}