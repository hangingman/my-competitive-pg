lines = <<'EOS'
3 2
1 7 2
7 8 1
8 12 1
EOS

#lines = $stdin.read
array = lines.split("\n")

TIME = 10**5

N,C = array[0].split(" ").map(&:to_i)

mat = Array.new(C).map{Array.new(TIME, 0)}

array[1..array.length].each do |rec|
  s,e,c = rec.split(" ").map(&:to_i)
  mat[c-1][s] += 1
  mat[c-1][e+1] -= 1
end

#p mat

mat.map! do |rec|
  rec.map.reduce([]) do |acc, e|
    acc << (acc == [] ? e : acc.last + e)
  end
end

#mat.each{|rec| puts rec.to_s}

add_mat = mat.transpose.map{|a| a.inject(:+) }

#p add_mat

puts add_mat.max
