def cycle_finding(n)

  p, q = 1, 1
  s, t = 1, 1 # start : s, goal : t

  while true
    p = (p*10) % n
    q = (q*10) % n
    q = (q*10) % n
    break if p==q
  end

  if p!=0
    q = 1;
    s = 1;
    while p!=q
      s+=1
      p = (p*10) % n
      q = (q*10) % n
    end
    q = (q*10) % n
    t = s
    while p!=q
      t+=1
      q = (q*10) % n
    end
  end
  cycle = t-s+1

  puts "1/#{n} = #{1.to_f/n.to_f} : #{cycle}"
  cycle
end

a = 1.upto(1000).to_a.map do |n|
  cycle_finding(n)
end

puts a.max
