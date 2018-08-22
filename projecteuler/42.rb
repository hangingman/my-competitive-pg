ALPHA_TABLE = ('a'..'z').to_a
$word_value_table = {}

def C(n)
  n*(n+1)/2
end

$triangles = (1..10**3).map do |n|
  {n=>C(n)}
end

def word_value(s)
  word = s.split("").map do |c|
    c.downcase
  end.sort

  unless $word_value_table.has_key?(word)
    wv = word.map do |c|
      ALPHA_TABLE.index(c)+1
    end.inject(&:+)
    $word_value_table[word] = wv
  end

  $word_value_table[word]
end

#wv = word_value("SKY")
#puts $triangles.detect{|hash| hash.values.include? wv}.keys
ans = 0

File.open("p042_words.txt", "r") do |f|
  s = f.read.gsub(/\"/, "")
  s.split(",").each do |word|
    wv = word_value(word)
    triangle = $triangles.detect{|hash| hash.values.include? wv}
    unless triangle.nil? or triangle.empty?
      ans += 1
    end
  end
end

puts ans
