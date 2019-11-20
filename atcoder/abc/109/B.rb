lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
W = array[1..N+1]

if W.uniq.length != N
  puts 'No'
else
  ans = true
  W.each_cons(2) do |phrase|
    ans = false if phrase.first.split("").last != phrase.last.split("").first
  end

  if ans
    puts 'Yes'
  else
    puts 'No'
  end
end
