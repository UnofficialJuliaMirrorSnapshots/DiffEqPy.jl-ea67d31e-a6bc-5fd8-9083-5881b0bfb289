module DiffEqPy

using Reexport
@reexport using DifferentialEquations
using PyCall
pysolve = PyCall.pyfunctionret(solve,Any,Vararg{PyCall.PyAny})

const inspect = PyNULL()
function __init__()
    copy!(inspect, pyimport("inspect"))
end

export pysolve

function DiffEqBase.numargs(f::PyCall.PyObject)
    haskey(f,:py_func) ? _f = f[:py_func] : _f = f
    if PyCall.pyversion < v"3.0.0"
        return length(first(inspect[:getargspec](_f)))
    else
        return length(first(inspect[:getfullargspec](_f)))
    end
end

end # module
