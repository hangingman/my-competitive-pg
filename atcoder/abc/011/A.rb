lines = <<'EOS'
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

if N==12
  puts 1
else
  puts N+1
end
