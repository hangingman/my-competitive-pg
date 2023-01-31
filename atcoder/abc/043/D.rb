lines = <<'EOS'
aa
EOS

#lines = $stdin.read
array = lines.split("\n")

line = array[0]
words = line.split("")

if words.size == 2 and words[0]==words[1]
  puts "1 2"
  exit 0
end

words.each_cons(3).with_index(1) do |chunk,idx|
  if chunk[0]==chunk[2]
    puts "#{idx} #{idx+2}"
    exit 0
  end
  if chunk[0]==chunk[1]
    puts "#{idx} #{idx+1}"
    exit 0
  end
  if chunk[1]==chunk[2]
    puts "#{idx} #{idx+2}"
    exit 0
  end
end

puts "-1 -1"
