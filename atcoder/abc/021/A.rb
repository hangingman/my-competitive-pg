lines = <<'EOS'
5
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

puts N / 1
(1..N).each{|one| puts 1}
