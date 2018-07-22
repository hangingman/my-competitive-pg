lines = <<'EOS'
kyoto
tokyo
EOS

#lines = $stdin.read
array = lines.split("\n")
S,T = array[0].split(""),array[1].split("")

for i in 0..S.length
  if S.rotate(i).join == T.join
    puts "Yes" ; exit 0
  end
end

puts "No"
