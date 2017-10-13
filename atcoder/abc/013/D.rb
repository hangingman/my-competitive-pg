lines = <<'EOS'
5 7 2
1 4 3 4 2 3 1
EOS

#lines = $stdin.read
array = lines.split("\n")

def fact(n, a=1)
  return a if n == 0
  fact(n-1, n*a)
end

N,M,D = array[0].split(" ").map(&:to_i)
A     = array[1].split(" ").map(&:to_i)

st    = 1.upto(N).to_a
to    = 1.upto(N).to_a

for a in A.reverse
  to[a], to[a-1] = to[a-1],to[a]
end

if D != 1
  d = D % fact(N)
  1.upto(d) do |i|
    #puts "concat! D =#{i}"
    neo_to = Array.new(N)

    to.each_with_index do |elem,idx|
      neo_to[idx] = st[elem-1]
    end
    st = neo_to
    #puts st.to_s
  end
  st.each{ |t| puts t }
else
  to.each{ |t| puts t }
end
