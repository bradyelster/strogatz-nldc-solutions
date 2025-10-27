# try plotting a function with fixed points and arrows 
# this is similar to Strogatz in his textbook
using Plots, LaTeXStrings

theme(:default)
x = LinRange(-2.0, 2.0, 100)
f(x) = x^3
p = Plots.plot(x, f.(x), lw=2, color="black", label="function", xlabel=L"x", ylabel=L"\dot{x}", ylims=(-4, 4))
Plots.annotate!(p, 0, 0, "◐") # thats \cirfl
Plots.annotate!(p, -1, 0, "▶") # thats \blacktriangleright
Plots.annotate!(p, 1, 0, "▶", framestyle=:origin)