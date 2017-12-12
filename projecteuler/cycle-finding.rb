def cycle_finding(n)

  puts "1/#{n} = #{1.to_f/n.to_f}"

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
  return t-s+1;
end


p cycle_finding(7)
