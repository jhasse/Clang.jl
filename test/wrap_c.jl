using Base.Test
using Clang.wrap_c

wc = wrap_c.init(;  headers = ["cxx/cbasic.h"])
hdr_tunits = wrap_c.parse_c_headers(wc)

# test func1
tunit = hdr_tunits["cxx/cbasic.h"]
func1 = search(tunit, "func1")[1]
buf = Any[]

wrap_c.wrap(wc, buf, func1, "test")

@test buf[1] == quote
    function func1(a::Cint,b::Cdouble,c::Ptr{Cdouble},d::Ptr{Void})
        ccall((:func1,test),Cint,(Cint,Cdouble,Ptr{Cdouble},Ptr{Void}),a,b,c,d)
    end
end

