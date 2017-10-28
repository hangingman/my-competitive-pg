lines = <<'EOS'
10
10
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
K = array[1].to_i

#
# opA = * 2 of shown
# opB = + K of shown
# ------------------
# opA + opB = N times
#
# 1<=N, K<=10
#
def show_board(a, n, k)
  e = 1
  b = n - a

  1.upto(a) do |idx|
    e = e * 2
    # puts "x2 -> e = #{e}"
  end
  a.upto(n-1) do |idx|
    e = e + k
    # puts "+k -> e = #{e}"
  end
  e
end

#puts "N = #{N}, K = #{K}"

min = (1..N).map do |a|
  show_board(a, N, K)
end.to_a.min

puts min
