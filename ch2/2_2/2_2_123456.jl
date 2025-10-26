# Fixed Points & Stability

# 2.2.1
using Plots, LaTeXStrings, DifferentialEquations
using Roots: find_zeros

# Function to analyze a given ODE
function analyze_ode(f, xrange, title; fixed_points=nothing)
    # Create figure with 3 subplots
    p1 = plot(xlabel="x", ylabel=L"\dot{x}", title="Vector Field: $title", legend=false)
    p2 = plot(xlabel="x", ylabel=L"\dot{x}", title="Fixed Points Analysis", legend=false)
    p3 = plot(xlabel="t", ylabel="x(t)", title="Time Evolution", legend=true)

    # Plot vector field
    x_vals = range(xrange[1], xrange[2], length=1000)
    xdot_vals = f.(x_vals)
    plot!(p1, x_vals, xdot_vals, linewidth=2)
    hline!(p1, [0], linestyle=:dash, color=:black, alpha=0.5)

    # Plot the same for fixed points analysis with zero line
    plot!(p2, x_vals, xdot_vals, linewidth=2)
    hline!(p2, [0], linestyle=:dash, color=:black, alpha=0.5)

    # Find and classify fixed points if not provided
    if fixed_points === nothing
        fixed_points = find_zeros(f, xrange[1], xrange[2])
    end

    # Classify stability and plot fixed points
    colors = [:red, :blue, :green, :orange, :purple]
    for (i, fp) in enumerate(fixed_points)
        # Stability classification using derivative
        df = (f(fp + 1e-6) - f(fp - 1e-6)) / 2e-6
        stability = df < 0 ? "Stable" : df > 0 ? "Unstable" : "Semi-stable"
        color = df < 0 ? :blue : df > 0 ? :red : :green

        # Plot fixed points
        scatter!(p1, [fp], [0], color=color, markersize=6, markerstrokewidth=2)
        scatter!(p2, [fp], [0], color=color, markersize=8, markerstrokewidth=2,
            annotation=(fp, 0.5, text("$stability\nx=$(round(fp, digits=3))", 8)))

        println("Fixed point at x = $(round(fp, digits=4)): $stability (f'(x) = $(round(df, digits=4)))")
    end

    # Solve ODE for different initial conditions and plot
    tspan = (0.0, 10.0)

    # Generate initial conditions around fixed points
    x0_vals = Float64[]
    if !isempty(fixed_points)
        for fp in fixed_points
            append!(x0_vals, [fp - 2, fp - 1, fp - 0.5, fp + 0.5, fp + 1, fp + 2])
        end
    else
        # If no fixed points, use some default values
        x0_vals = range(xrange[1] + 0.5, xrange[2] - 0.5, length=6)
    end

    # Filter initial conditions to be within reasonable range
    x0_vals = filter(x -> xrange[1] ≤ x ≤ xrange[2], unique(x0_vals))

    for (i, x0) in enumerate(x0_vals)
        # CORRECTED: Use scalar form for the ODE
        prob = ODEProblem((u, p, t) -> f(u), x0, tspan)
        sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8)
        plot!(p3, sol.t, sol.u, label="x₀ = $(round(x0, digits=2))", linewidth=2)
    end

    # Plot layout
    plot(p1, p2, p3, layout=(1, 3), size=(1200, 400))
end

# Now analyze each problem:

# Problem 2.2.1: ẋ = 4x² - 16
println("Analyzing 2.2.1: ẋ = 4x² - 16")
f1(x) = 4x^2 - 16
fixed_points_1 = [-2.0, 2.0]
analyze_ode(f1, (-3, 3), L"\dot{x} = 4x^2 - 16", fixed_points=fixed_points_1)

# Problem 2.2.2: ẋ = 1 - x¹⁴  
println("\nAnalyzing 2.2.2: ẋ = 1 - x¹⁴")
f2(x) = 1 - x^14
fixed_points_2 = [-1.0, 1.0]
analyze_ode(f2, (-1.5, 1.5), L"\dot{x} = 1 - x^{14}", fixed_points=fixed_points_2)

# Problem 2.2.3: ẋ = x - x³
println("\nAnalyzing 2.2.3: ẋ = x - x³")
f3(x) = x - x^3
fixed_points_3 = [-1.0, 0.0, 1.0]
analyze_ode(f3, (-2, 2), L"\dot{x} = x - x^3", fixed_points=fixed_points_3)

# Problem 2.2.4: ẋ = e^{-x} sin(x)
println("\nAnalyzing 2.2.4: ẋ = e^{-x} sin(x)")
f4(x) = exp(-x) * sin(x)
analyze_ode(f4, (-2π, 4π), L"\dot{x} = e^{-x} \sin(x)")

# Problem 2.2.5: ẋ = 1 + ½cos(x)
println("\nAnalyzing 2.2.5: ẋ = 1 + ½cos(x)")
f5(x) = 1 + 0.5cos(x)
analyze_ode(f5, (-2π, 2π), L"\dot{x} = 1 + \frac{1}{2} \cos(x)")

# Problem 2.2.6: ẋ = 1 - 2cos(x)
println("\nAnalyzing 2.2.6: ẋ = 1 - 2cos(x)")
f6(x) = 1 - 2cos(x)
analyze_ode(f6, (-2π, 2π), L"\dot{x} = 1 - 2 \cos(x)")

# Function to show analytical solutions where possible
function show_analytical_solutions()
    println("\n" * "="^60)
    println("ANALYTICAL SOLUTIONS SUMMARY:")
    println("="^60)

    println("\n2.2.1: ẋ = 4x² - 16")
    println("Separable: ∫dx/(x²-4) = ∫4dt")
    println("Solution: x(t) = 2(1 + Ce^{8t})/(1 - Ce^{8t})")
    println("Or equivalently: x(t) = -2tanh(4t + C)")

    println("\n2.2.2: ẋ = 1 - x¹⁴")
    println("Separable but high power makes closed form impractical")
    println("Numerical methods recommended")

    println("\n2.2.3: ẋ = x - x³")
    println("Separable: ∫dx/(x(1-x)(1+x)) = ∫dt")
    println("Solution: ln|x| - 0.5ln|1-x²| = t + C")
    println("Or: x(t) = ±1/√(1 + Ce^{-2t})")

    println("\n2.2.4: ẋ = e^{-x}sin(x)")
    println("Non-separable in elementary functions")
    println("Requires numerical solution")

    println("\n2.2.5: ẋ = 1 + ½cos(x)")
    println("Separable but integral ∫dx/(1 + ½cos(x)) involves elliptic functions")
    println("Numerical solution preferred")

    println("\n2.2.6: ẋ = 1 - 2cos(x)")
    println("Similar to 2.2.5, requires elliptic integrals for analytical solution")
    println("Numerical methods are practical approach")
end

show_analytical_solutions()