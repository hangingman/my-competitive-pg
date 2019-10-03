lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i

if N == 1
   puts 1
elsif N % 2 == 0
   puts N / 2
else
   puts (N / 2) + 1
end
