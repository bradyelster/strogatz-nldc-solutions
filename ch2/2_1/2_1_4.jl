# 2.1: A Geometric Way of Thinking

# 2.1.4
using OrdinaryDiffEq, Plots, LaTeXStrings

# analytic solution for x0 = π/4
given(t) = 2 * atan(exp(t) / (1 + sqrt(2)))
analytic(x, x₀) = log(abs((csc(x₀) + cot(x₀)) / (csc(x) + cot(x))))

tvals = LinRange(0, 4π, 1000)

sol = solve(ODEProblem((x, p, t) -> sin(x), π / 4, (0, 4π)), Tsit5())
plot(sol,
    title=L"$\dot{x} = \sin{(x)}; \ x_0 = \pi/4$",
    label="numeric",
    xlabel=L"t",
    ylabel=L"x(t)",
    linewidth=3,
    yticks=([0, π / 2, π], [L"0", L"\pi/2", L"\pi", L"3\pi/2", L"2\pi"]))
plot!(tvals, given.(tvals), label="analytic", ls=:dash, lw=3)

# Note: 2.1.4 (b) is not worth the effort due to shear difficulty-
# -and the fact that this would give little/no intuition or insight- 
# -into the general behavior of the solutions to this problem!