# 2.1: A Geometric Way of Thinking

# 2.1.1 - 2.1.3
# Consider ̇x = sin(x)
# 2.1.1: find all fixed points -> where ̇x = 0
using Plots, LaTeXStrings

# Define an interval
a, b = 0, 4π

# Find zeros: sin(x) = 0
# For sin(x), zeros occur at x = nπ
zeros_x = range(ceil(a / π), floor(b / π), step=1) .* π
zeros_x = zeros_x[a.<=zeros_x.<=b]

# 2.1.2: find points where ̇x is maximum (max. positive velocity)
# Find maxima: sin(x) = 1 at x = π/2 + 2nπ
maxima_x = range(ceil((a - π / 2) / (2π)), floor((b - π / 2) / (2π)), step=1) .* 2π .+ π / 2
maxima_x = maxima_x[a.<=maxima_x.<=b]

# bonus: find points where ̇x is minimum (max. leftward velocity)
# Find minima: sin(x) = -1 at x = 3π/2 + 2nπ
minima_x = range(ceil((a - 3π / 2) / (2π)), floor((b - 3π / 2) / (2π)), step=1) .* 2π .+ 3π / 2
minima_x = minima_x[a.<=minima_x.<=b]

# 2.1.3: acceleration is x=cos(x), find where this is at a maximum (max. positive acceleration)
# Find where ̈x=cos(x) is at a maximum: cos(x) = 1 at x = 2nπ
max_pos_accel_x = range(ceil(a / (2π)), floor(b / (2π)), step=1) .* 2π
max_pos_accel_x = max_pos_accel_x[a.<=max_pos_accel_x.<=b]

# Plot
x = range(a, b, length=1000)
plot(x, sin.(x), label="", linewidth=3, legend=:best)
scatter!(zeros_x, sin.(zeros_x), label="fixed points", markersize=6)
scatter!(maxima_x, sin.(maxima_x), label="max. pos. velocity", markersize=6)
scatter!(minima_x, sin.(minima_x), label="max. neg. velocity", markersize=6)
scatter!(max_pos_accel_x, sin.(max_pos_accel_x), label="max. pos. accel.", markersize=6, color=:purple, markershape=:x)
xlabel!(L"x")
ylabel!(L"\sin{(x)}")
title!(L"$\dot{x} = \sin{(x)}$")