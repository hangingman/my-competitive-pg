def T(n)
  n*(n+1)/2
end
def P(n)
  n*(3*n-1)/2
end
def H(n)
  n*(2*n-1)
end

TT = (1..10**5).map{|n| T(n)}
PT = (1..10**5).map{|n| P(n)}
HT = (1..10**5).map{|n| H(n)}

p (TT&PT&HT).detect{|x| x>40755}
