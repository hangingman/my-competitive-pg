lines = <<'EOS'
5 7 2
1 4 3 4 2 3 1
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M,D = array[0].split(" ").map(&:to_i)
A     = array[1].split(" ").map(&:to_i)

st    = 1.upto(N).to_a
to    = 1.upto(N).to_a

for a in A.reverse
  to[a], to[a-1] = to[a-1],to[a]
end

1.upto(D) do |i|
  #puts "concat! D =#{i}"
  neo_to = Array.new(N)

  to.each_with_index do |elem,idx|
    neo_to[idx] = st[elem-1]
  end
  st = neo_to
  #puts st.to_s
end

st.each{ |t| puts t }
