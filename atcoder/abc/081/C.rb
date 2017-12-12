lines = <<'EOS'
10 3
5 1 3 2 4 1 1 2 3 4
EOS

#lines = $stdin.read
array = lines.split("\n")

N,K = array[0].split(" ").map(&:to_i)
A   = array[1].split(" ").map(&:to_i)

ans = A.dup.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

if ans.keys.length > K
  req = ans.keys.length - K
  ts = ans.sort_by {|_key, value| value}
  count = ts.take(req).map{|k,v| v}.inject(&:+)
  puts count
else
  puts 0
end
