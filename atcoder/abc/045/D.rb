lines = $stdin.read

def gen_square(a,b,h,w)
  [
    [a-2,b-2],[a-1,b-2],[a,b-2],
    [a-2,b-1],[a-1,b-1],[a,b-1],
    [a-2,b  ],[a-1,b  ],[a,b  ],
  ].select do |elem|
    elem[0] >= 0 and elem[1] >= 0 and elem[0] < h-2 and elem[1] < w-2
  end
end

array = lines.split("\n")
H,W,N = array[0].split(" ").map(&:to_i)
sum = {}

array[1..N].each do |line|
  a,b = line.split(" ").map(&:to_i)
  gen_square(a-1,b-1,H,W).each do |coord|
    key = "#{coord[0]}-#{coord[1]}"
    if sum.has_key?(key)
      sum[key] += 1
    else
      sum[key] = 1
    end
  end
end

ans = Array.new(10,0)
sum.each_value do |value|
  ans[value] += 1
end
ans[0] = (H-2)*(W-2) - sum.length
puts ans
