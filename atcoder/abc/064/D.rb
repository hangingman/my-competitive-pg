
lines = <<'EOS'
8
))))((((
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
S = array[1]

cnt,pre = 0,0
for i in 0...N
  if S[i] == '('
    cnt+=1
  else
    cnt-=1
    pre = [pre,-cnt].max if cnt<0
  end
end

ans = (['(']*pre).join+S
n = N+pre

cnt = 0
for i in 0...n
  if ans[i] == '('
    cnt+=1
  else
    cnt-=1
  end
end

ans = ans+([')']*cnt).join

puts ans
