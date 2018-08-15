lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")
N,K = array[0].split(" ").map(&:to_i)

if N%K==0
  puts 0
else
  puts 1
end
