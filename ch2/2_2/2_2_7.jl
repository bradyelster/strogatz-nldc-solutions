# Fixed Points & Stability

using Plots

f(x) = exp(x) - cos(x)
xvals = LinRange(-3, 3, 1000)

plot(xvals, f.(xvals))
plot!(xvals, exp.(xvals))
plot!(xvals, cos.(xvals))

