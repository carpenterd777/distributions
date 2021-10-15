include("./distributions.jl")
import .Distributions
using Test

function isapprox(x, y)::Bool
		Base.isapprox(x, y, atol=0.001)
end

@testset "discrete distributions" begin
	@test Distributions.binomial(4, 0.3, 6) ≈ 0.059535
	@test Distributions.negative_binomial(3, 0.2, 1) ≈ 0.128
	@test Distributions.geometric(3, 0.5) ≈ 0.125
	@test isapprox(Distributions.hypergeometric(5, 50, 5, 10), 0.0001189375)
	@test Distributions.multinomial([1, 2, 3], [0.2, 0.3, 0.5], 6) ≈ 0.135	
end

@testset "poisson processes" begin
		@test isapprox(Distributions.poisson(0, 2, 1), 0.135) 
		@test isapprox(Distributions.exponential(150, (1 / 760)), 0.179)
		@test isapprox(Distributions.weibull(4, 0.5, 2), 0.9817)
end

