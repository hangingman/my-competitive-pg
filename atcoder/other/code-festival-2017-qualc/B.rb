lines = <<'EOS'
10
90 52 56 71 44 8 13 30 57 84
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
A = array[1].split(" ").map(&:to_i)

all_possiblity = 1
odd_possibiity = 1

for a in A
  cand = (a-1).upto(a+1).to_a
  odd  = cand.select{|e| e % 2 != 0}
  all_possiblity = all_possiblity * cand.length
  odd_possibiity = odd_possibiity * odd.length
end

# all possibility
puts all_possiblity - odd_possibiity
