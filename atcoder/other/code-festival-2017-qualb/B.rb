lines = <<'EOS'
5
3 1 4 1 5
3
5 4 3
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
d = array[1].split(" ").map(&:to_i)
M = array[2].to_i
t = array[3].split(" ").map(&:to_i)

# p N
# p d
# p M
# p t

# M - N, and if there are something it's not sufficient
# scores.delete_if {|key, val| val < 50 }
having = Hash.new(0).tap do |h|
  d.each do |elem|
    #p elem
    h[elem] += 1 # unless elem.nil?
  end
end

ideal  = Hash.new(0).tap do |h|
  t.each do |elem|
    #p elem
    h[elem] += 1 # unless elem.nil?
  end
end

if ideal.any?{|k,v| not having.has_key?(k) or (having.has_key?(k) and having[k] < ideal[k]) }
  puts "NO"
else
  puts "YES"
end
