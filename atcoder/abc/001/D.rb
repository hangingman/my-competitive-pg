lines = <<'EOS'
1
0000-2400
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
vec = Array.new(24*60+1){0}

def round_st(n)
  if n % 5 == 0
    n
  else
    5 * (n/5)
  end
end

def round_ed(n)
  if n % 5 == 0
    n
  else
    5 * (n/5) + 5
  end
end

array[1..N].each do |s|
  start,finish = s.split("-")
  # puts "start  = #{start[0,2].to_i*60  + start[2,2].to_i}"
  # puts "finish = #{finish[0,2].to_i*60 + finish[2,2].to_i}"
  s = start[0,2].to_i*60  + round_st(start[2,2].to_i)
  f = finish[0,2].to_i*60 + round_ed(finish[2,2].to_i)
  vec[s] = vec[s] + 1
  vec[f] = vec[f] - 1
end

for i in 1...vec.length
  vec[i] += vec[i-1]
end

is_rainny = false

vec.each_with_index do |v,i|
  if v == 0
    # not rain
    if is_rainny
      is_rainny = false
      printf "-%02d%02d\n", i/60,i%60
    end
  else
    # rain
    if not is_rainny
      is_rainny = true
      printf "%02d%02d", i/60,i%60
    end
  end
end
