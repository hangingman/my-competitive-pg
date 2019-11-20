lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
A = array[1].split(" ").map(&:to_i)

def oracle1(n)
  return n.odd?
end
def oracle2(n)
  return (n + 1) % 3!=0
end

ans = 0
A.each do |a|
  while not (oracle1(a) and oracle2(a))
    ans += 1
    a = a - 1
  end
end
puts ans
