lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
dishes = array[1..1+N].map(&:to_i).uniq.sort.reverse

if dishes.length > 1
   puts dishes[1]
else
   puts dishes[0]
end
