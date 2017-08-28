# coding: utf-8

#lines = <<'EOS'
#EOS

lines = $stdin.read
array = lines.split("\n")

Q,H,S,D = array[0].split(" ").map(&:to_i)
N = array[1].to_i

litter = {}
litter[:q] = 0.25
litter[:h] = 0.5
litter[:s] = 1
litter[:d] = 2

#
# nリットル
#
def most_cheap_with_four(n)
  prices = {}
  times  = {}

  prices[:q] = (n/0.25) * Q if n/0.25 != 0
  prices[:h] = (n/0.5)  * H if n/0.5  != 0
  prices[:s] = (n/1)    * S if n/1    != 0
  prices[:d] = (n/2)    * D if n/2    != 0

  times[:q]  = n/0.25       if n/0.25 != 0
  times[:h]  = n/0.5        if n/0.5  != 0
  times[:s]  = n/1          if n/1    != 0
  times[:d]  = n/2          if n/2    != 0

  # puts "#{(n/0.25) * Q} yen"
  # puts "#{(n/0.5)  * H} yen"
  # puts "#{(n/1)    * S} yen"
  # puts "#{(n/2)    * D} yen"

  m = prices.sort_by { |key, value| value }.first
  # [:kind, :sum, :times]
  { kind: m[0], sum: m[1].floor, times: times[m[0]].floor }
end

n = N
summary = 0

while n != 0
  ret = most_cheap_with_four(n)
  n = n - litter[ret[:kind]] * ret[:times]
  #puts ret.to_s
  summary = summary + ret[:sum]
  #puts summary.floor
end

puts summary.floor
