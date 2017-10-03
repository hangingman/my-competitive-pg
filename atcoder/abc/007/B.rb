lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")
if array[0].to_s == 'a'
  puts -1
else
  puts "a"
end
