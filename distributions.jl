module Distributions
#=
# Statistical distribution functions.
=#

# Counting methods

# to simulate syntax such as 3! == 6
function ❕(x)
	if x < 20
		factorial(x)
	else
		factorial(big(x))
	end
end



export choose, binomial, negative_binomial, geometric, multinomial, poisson, exponential, weibull

"""
	choose(n, k)
Counting method. Computes the number of ways you can choose n distinct objects from k distinct objects.
"""
function choose(n::Integer, k::Integer)::Integer
		❕(n) / (❕(k) * ❕(n-k))
end

# Discrete distributions

"""
	binomial(x, p, n)
Compute the probability that `x` successes will happen in `n` trials if a success has `p` odds of occurring.
"""
function binomial(x::Integer, p::Real, n::Integer)::Real
		choose(n, x) * (p ^ x) * ((1 - p) ^ (n - x))
end
	
"""
	negative_binomial(x, p, n)
Compute the probability that `x` trials will result in `n` successes if a success has `p` odds of occurring.
"""
function negative_binomial(x::Integer, p::Real, r::Integer)::Real
		choose(x - 1, r - 1) * (p ^ r) * ((1 - p) ^ (x - r)) 
end

"""
	geometric(x, p)
Compute the probability that `x` trials are required for the 1st success where a success has `p` odds of occurring.
A special case of the negative_binomial distribution.
"""
function geometric(x::Integer, p::Real)::Real
		p * ((1 - p) ^ (x - 1))
end

"""
	hypergeometric(x, N, n, r)
Compute the probability that there will be `x` successes in a sample of size `n` given that there are `r` successes
in the population, the population is of size `N`, and selected items are finite and not replaced.
"""
function hypergeometric(x::Integer, N::Integer, n::Integer, r::Integer)::Real
		(choose(r, x) * choose(N - r, n - x)) / choose(N, n) 
end

"""
	multinomial(outcomes, probabilities, n)
Compute the probability that in `n` trials, there will be some number of outcomes for each type of outcome.
If `i` is some valid index in outcomes and probabilities, then `probabilities[i]` corresponds to the odds of 
1 instance of `outcomes[i]` occurring.

Note that the sum of all of the indices of `probabilities` should be 1.
"""
function multinomial(outcomes::Vector{Int}, probabilities::Vector{Float64}, n::Integer)::Real
		xs_ps = []
		for i in 1:length(outcomes) 
				push!(xs_ps, (outcomes[i], probabilities[i]))
		end

		alloutcomesfactorial = reduce(*, map(❕, outcomes))
		all_probs_raised_to_outcomes = reduce(*, map(x -> x[2] ^ x[1], xs_ps))

		(❕(n) * all_probs_raised_to_outcomes) / alloutcomesfactorial
end

# Poisson processes

"""
	poisson(x, λ, t)
Compute the probability that `x` events will occur given that they occur at a rate `λ` over some
distance or time `t`.
"""
function poisson(x::Integer, λ::Real, t::Real)::Real
		(ℯ^(-λ*t)) * ((λ*t)^x) / (❕(x))
end

"""
	exponential(t, λ)
Compute the probability that some time or distance `t` will need to be waited until the next
time an event occurs given that they occur on average at a rate `λ`.
"""
function exponential(t::Real, λ::Real)::Real
		1 - (ℯ)^(-λ*t)
end

"""
	weibull(t, λ, α)
Compute the probability that some event will occur after some time or distance `t` has elapsed,
given that `λ` is some rate at which the event occurs on average and `α` is a constant determining
how the probability varies over time.
"""
function weibull(t::Real, λ::Real, α::Real)::Real
		1 - (ℯ)^(-(λ*t) ^ α)
end

end # of module
