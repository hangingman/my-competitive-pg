lines = <<'EOS'
148
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i

harsed = N.to_s.split("").map(&:to_i).inject(&:+)

if N % harsed == 0 and N >= harsed
  puts "Yes"
else
  puts "No"
end
