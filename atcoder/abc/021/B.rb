# start
lines = <<'EOS'
4
1 4
3
2 1 3
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
H,T = array[1].split(" ").map(&:to_i)
K = array[2].to_i
P = array[3].split(" ").map(&:to_i)

route = [H,P,T].flatten

e_count = route.inject(Hash.new(0)){|h,v| h[v] += 1; h}

if e_count.count{|k,v| v > 1} > 0
  puts "NO"
else
  puts "YES"
end
