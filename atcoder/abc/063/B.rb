lines = $stdin.read
array = lines.split("\n")

s = array[0].to_s.split("")
u = s.uniq

if s.length != u.length
        puts "no"
else
        puts "yes"
end
