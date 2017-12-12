lines = <<'EOS'
2
-1 -3
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
A = array[1].split(" ").map(&:to_i)
ans = A.dup

count = 0

if ans.uniq.length == 1
  puts 0
  exit 0
end

ope_array = []

while true

  x,y = 0,0
  is_lis = false

  ans.each_cons(2).with_index do |arr,idx|
    x = idx
    y = idx+1
    if arr.first > arr.last
      is_lis = false
      if arr.first < 0 and arr.last < 0
        y = idx
        x = idx+1
      end
      break
    else
      is_lis = true
    end
  end

  break if is_lis

  ans[y] += ans[x]
  count += 1
  #puts "#{ans.to_s} #{x+1}, #{y+1}"
  ope_array << "#{x+1} #{y+1}"
end

puts count
ope_array.each{|ope| puts ope}
