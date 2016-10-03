module Interp

immutable LinInterp
    grid::Array
    vals::Array
end

function Base.call(f::LinInterp, x::Real)
    grid = f.grid
    vals = f.vals
    
    if x <= grid[1]
        index_1 = 2
        index_2 = 1
    elseif x >= grid[length(grid)]
        index_1 = length(grid) 
        index_2 = length(grid) - 1
    else
        index_1 = searchsortedlast(grid, x)
        index_2 = index_1 + 1
    end
    x_1 = grid[index_1]
    x_2 = grid[index_2]
    y_1 = vals[index_1]
    y_2 = vals[index_2]

    y = ((y_2- y_1)/(x_2 - x_1))*(x - x_1) + y_1
    return y
end

function Base.call{T<:Real}(f::LinInterp, x::AbstractVector{T})
    grid = f.grid
    vals = f.vals
    
    y = zeros(length(x))
    for i in 1:length(x)
        y[i] = f(x[i])
    end
    return y
end

end