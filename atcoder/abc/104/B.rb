lines = <<'EOS'
AtCoCo
EOS

#lines = $stdin.read
array = lines.split("\n")
S = array[0].split("")

def is_lower?(c)
  c >= 'a' && c <= 'z'
end

str = S.dup
low = str.reject{|s| s=='A' or s=='C'}.all?{|c| is_lower?(c)}

if S.first=='A' and S[2...S.length-1].count{|s| s=='C'}==1 and low
  puts "AC"
else
  puts "WA"
end
