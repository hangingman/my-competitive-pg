INF=10**9

def meet_in_the_middle(n,w,item)
  tmp_h = {}
  tmp_a = []

  s = 0
  s1 = item[0...n/2]
  s,len = 0,s1.length

  [0,1].repeated_permutation(len) do |a|
    tmp_h = {:v => 0, :w => 0}
    s1.zip(a).each do |test|
      i,bit = test.first,test.last
      if bit==1
        tmp_h[:v] += i.first
        tmp_h[:w] += i.last
      end
    end
    tmp_a << tmp_h if tmp_h[:w] <= w
    s += 1
  end

  tmp_a = tmp_a.sort_by{|m| -m[:v]}
  tmp_b = []
  ans_v = 0

  s2 = item[n/2...n]
  s,len = 0,s2.length
  [0,1].repeated_permutation(len) do |a|
    tmp_h = {:v => 0, :w => 0}

    s2.zip(a).each do |test|
      i,bit = test.first,test.last
      if bit==1
        tmp_h[:v] += i.first
        tmp_h[:w] += i.last
      end
    end

    if tmp_h[:w] <= w
      x = tmp_a.detect{|e| tmp_h[:w] + e[:w] <= w }
      ans_v = [ans_v, x[:v] + tmp_h[:v]].max unless x.nil?
    end
    s += 1
  end

  puts ans_v
end

def solve_sigma_v(n,w,wv_h)
  max_n=n
  max_v=1000
  dp = Array.new(max_n+1).map{Array.new(max_n*max_v+1, INF)}

  dp[0][0] = 0
  for i in 0...n
    for j in 0...(max_n*max_v)
      if j < wv_h[i].first
        dp[i+1][j] = dp[i][j]
      else
        dp[i+1][j] = [dp[i][j], dp[i][j-wv_h[i].last] + wv_h[i].first].min
      end
    end
  end
  ans = 0
  for i in 0..max_n*max_v
    ans = i if dp[n][i] <= w
  end
  puts ans
end

def solve_sigma_w(n,w,wv_h)
  max_n=n
  max_w=1000
  dp = Array.new(max_n+1).map{Array.new(max_n*max_w+1, -INF)}

  dp[0][0] = 0
  for i in 0...n
    for j in 0...(max_n*max_w)
      if j < wv_h[i].last
        dp[i+1][j] = dp[i][j]
      else
        dp[i+1][j] = [dp[i][j], dp[i][j-wv_h[i].first] + wv_h[i].last].max
      end
    end
  end
  puts dp.max.max
end

lines = $stdin.read
array = lines.split("\n")
N,W  = array[0].split(" ").map(&:to_i)
max_v,max_w = 0,0

item = array[1..N+1].map do |str|
  v,w = str.split(" ").map(&:to_i)
  max_v,max_w = [v,max_v].max, [w,max_w].max
  [v,w]
end

if max_v>1000 or max_w>1000
  if max_v <= 1000
    solve_sigma_v(N,W,item)
  else
    # max_w <= 1000
    solve_sigma_w(N,W,item)
  end
else
  meet_in_the_middle(N,W,item)
end
