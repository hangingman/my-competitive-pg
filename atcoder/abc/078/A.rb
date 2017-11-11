lines = <<'EOS'
A B
EOS

#lines = $stdin.read
array = lines.split("\n")

X,Y = array[0].split(" ").map(&:to_s)

hex = { 'A' => 10,
        'B' => 11,
        'C' => 12,
        'D' => 13,
        'E' => 14,
        'F' => 15}

if hex[X] == hex[Y]
  puts "="
elsif hex[X] > hex[Y]
  puts ">"
else
  puts "<"
end
