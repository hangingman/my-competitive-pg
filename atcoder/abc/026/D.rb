lines = <<'EOS'
1 1 1
EOS

#lines = $stdin.read
array = lines.split("\n")

A,B,C = array[0].split(" ").map(&:to_i)

def f(t, a, b, c)
  ans = a*t + b * Math.sin(c*t*Math::PI)
  #puts ans
  ans
end

def ceil_index(l, r, key, a, b, c)
  #puts "left:#{l},right:#{r},key=#{key}"
  while r-l > 0.00000000001
    #m = l + ((r-l).to_f/2).to_f
    m = l + (r-l)/2
    t = f(m,a,b,c)

    if t == key
      puts t
      exit(0)
    elsif key < t
      r = m
    else
      l = m
    end
  end
  r
end

t = 0
while true
  t += 1
  ans = f(t,A,B,C)
  if ans==100
    puts t
    exit(0)
  elsif ans>100
    break
  end
end

t = ceil_index((t-1).to_f, t.to_f, 100, A, B, C)

#puts "---"
#puts f(t,A,B,C)
#puts f(1.63372043395339,A,B,C)

puts t
