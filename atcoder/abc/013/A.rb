lines = <<'EOS'
A
EOS

#lines = $stdin.read
array = lines.split("\n")

hash = { 'A' => 1,
         'B' => 2,
         'C' => 3,
         'D' => 4,
         'E' => 5 }

puts hash[array[0].to_s]
