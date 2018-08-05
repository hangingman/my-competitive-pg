# coding: utf-8
lines = <<'EOS'
2 700
3 500
5 800
EOS

#lines = $stdin.read
array = lines.split("\n")
D,G = array[0].split(" ").map(&:to_i)
p,b = [],[]

array[1...D+1].each do |str|
  p << str.split(" ")[0].to_i
  b << str.split(" ")[1].to_i
end

ans = {}
p.each_with_index do |point,i|
  tmp = (1..point).to_a.map{|e| e*100*(i+1)}
  tmp[tmp.length-1] += b[i]
  tmp.each_with_index do |e,i|
    if ans.has_key?(i+1)
      ans[i+1] = e if ans[i+1]<e
    else
      ans[i+1] = e
    end
  end
end

answer = ans.detect{|k,v| v >= G}

if answer.nil?
  puts answer.first+1
else
  puts answer.first
end
