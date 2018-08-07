lines = <<'EOS'
123456789
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

if N.even?
  puts N-1
else
  puts N+1
end
