using MLStyle

abstract type Statement end

Statement(x) = convert(Statement, x)

struct Let <: Statement
    name :: Symbol
    value
end

varName(st :: Let) = st.name

struct Follows <: Statement
    name :: Symbol
    dist 
end

varName(st :: Follows) = st.name

struct Return <: Statement
    value 
end

varName(st :: Return) = nothing

function convert(Statement, expr :: Expr)
    @match expr begin
        :($x ~ $dist)  => Follows(x, dist)
        :($x = $value) => Let(x, value)
        :(return $x)   => Return(x)
    end
end

varName(::Nothing) = nothing

convert(Statement, node :: LineNumberNode) = nothing
