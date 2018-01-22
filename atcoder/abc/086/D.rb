def imos_2d(a)
  h,w = a.length,a.first.length
  s = Array.new(h+1).map{Array.new(w+1,0)}
  for i in 0...h
    for j in 0...w
      s[i+1][j+1] = a[i][j]
    end
  end
  for i in 0...h+1
    for j in 0...w
      s[i][j+1] += s[i][j]
    end
  end
  for i in 0...h
    for j in 0...w+1
      s[i+1][j] += s[i][j]
    end
  end
  s
end

def sum(s,i,j,h,w)

  puts "s[#{i+h}][#{j+w}] = #{s[i+h][j+w]}"
  puts "s[#{i}][#{j+w}] = #{s[i][j+w]}"
  puts "s[#{i}][#{j}] = #{s[i][j]}"
  puts "s[#{i+h}][#{j}] = #{s[i+h][j]}"

  s[i+h][j+w] - s[i][j+w] + s[i][j] - s[i+h][j]
end

lines = <<'EOS'
6 2
1 2 B
2 1 W
2 2 B
1 0 B
0 6 W
4 5 W
EOS

#lines = $stdin.read
array = lines.split("\n")
N,K   = array[0].split(" ").map(&:to_i)

coords = array[1..N+1].map do |str|
  x,y,color = str.split(" ")
  x,y = x.to_i,y.to_i
  x,y,color = x,y+K,'B' if color == 'W'
  x,y = x%2*K,y%2*K
  puts "#{x},#{y},#{color}"
  [x,y,color]
end

a = Array.new(2*K){Array.new(2*K,0)}
coords.each{|c| a[c[0]][c[1]] += 1 }

a.each{|r| p r}

s = imos_2d(a)

p s.length
p s.first.length
s.each{|r| p r}

# for i in 0...s.length-K
#   for j in 0...s.first.length-K
#     puts "i=#{i},j=#{j},h=#{i+K-1},w=#{j+K-1}"
#     p sum(s,i,j,i+K-1,j+K-1)
#   end
# end

# (0..s.length-1).each_cons(K) do |rows|
#   i,h = rows.first,rows.last
#   (0..s.length-1).each_cons(K) do |cols|
#     j,w = cols.first,cols.last
#     puts "i:#{i},j:#{j},h:#{h},w:#{w},sum:#{sum(s,i,j,h,w)}"
#   end
# end
