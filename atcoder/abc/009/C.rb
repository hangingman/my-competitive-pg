# coding: utf-8
lines = <<'EOS'
10 3
helloworld
EOS

#lines = $stdin.read
array = lines.split("\n")
N,K = array[0].split(" ").map(&:to_i)
S = array[1]

def available(t)
  s = S.split("").sort
  t.compact.each do |e|
    idx = s.index(e)
    s.delete_at(idx)
  end
  s.sort
end

s = S.split("")
t = Array.new(S.length, nil)

def check_rest_str(s,t)
  for j in 0..N-1
    if t[j].nil? and available(t).include?(s[j])
      t[j] = s[j]
    end
  end
  #p S.split("")
  #p t
  # 何個変える必要があるか数える
  switch_count = t.count{|e| e.nil?}
  # 残りを埋める
  for j in 0..N-1
    if t[j].nil?
      t[j] = available(t).shift()
    end
  end
  return switch_count,t
end

def count_diff(t)
  count = 0
  t.compact.each_with_index do |w,idx|
    count += 1 if w!=S.split("")[idx]
  end
  count
end

if K==0||K==1
  puts S
  exit 0
end

for i in 0..N-1
  av = available(t)
  for c in av
    # t[i]=cにできる？
    t[i]=c
    #p av
    #p t
    k = count_diff(t)
    switch_count,t_tmp = check_rest_str(s,t.dup)
    #puts "k=#{k},switch_count=#{switch_count}"
    if k + switch_count == K
      puts t_tmp.join
      exit 0
    elsif k + switch_count > K
      # 他を試す
    else
      # 次の文字へ
      break
    end
  end

end

# dehloworll
puts t.join
