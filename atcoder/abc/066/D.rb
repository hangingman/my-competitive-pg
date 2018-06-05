# coding: utf-8
# lines = <<'EOS'
# 32
# 29 19 7 10 26 32 27 4 11 20 2 8 16 23 5 14 6 12 17 22 18 30 28 24 15 1 25 3 13 21 19 31 9
# EOS

MOD = 1_000_000_007

lines = $stdin.read
array = lines.split("\n")

N  = array[0].to_i
A  = array[1].split(" ").map(&:to_i)

DUPL = A.group_by{|i| i}.reject{|k,v| v.one?}.keys.first

LEFT, RIGHT = A.map.with_index do |item,idx|
  [idx, item]
end.to_h.select do |k,v|
  v == DUPL
end.keys

DUPL_N = LEFT + (A.length - RIGHT - 1)
DUPL_N_ARR = (1..DUPL_N).to_a

A.each_with_index do |elem, idx|
  r = idx + 1
  p (A.combination(r).size - DUPL_N_ARR.combination(r-1).size) % MOD
end
