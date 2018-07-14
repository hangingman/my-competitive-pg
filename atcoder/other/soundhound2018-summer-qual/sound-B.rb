lines = <<'EOS'
abcdefgh
3
EOS

#lines = $stdin.read
array = lines.split("\n")
S = array[0].split("")
W = array[1].to_i

ans = ""
S.each_slice(W).map do |arr|
  ans << arr.first
end
puts ans
