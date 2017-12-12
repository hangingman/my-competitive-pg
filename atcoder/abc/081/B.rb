lines = <<'EOS'
6
382253568 723152896 37802240 379425024 404894720 471526144
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
A = array[1].split(" ").map(&:to_i)

count = 0
ans   = A.dup

while true
  if ans.all?{|a| a % 2 == 0}
    count += 1
    ans = ans.map{|a| a / 2}
  else
    break
  end
end

puts count
