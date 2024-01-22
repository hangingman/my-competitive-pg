N = gets.to_i
A = gets.split(" ").map(&:to_i)

k = A.uniq.size
if k.odd?
  puts k
else
  puts k-1
end
