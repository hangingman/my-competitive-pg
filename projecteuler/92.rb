require 'set'

def square_sum_each_digit(n)
  return n.to_s.split("").map{|d| d.to_i**2}.inject(&:+)
end

def find_cycle(n, group_89)
  memo = [n]
  t = n
  loop {
    t = square_sum_each_digit(t)
    memo << t
    return true, memo if t==89 or group_89.include?(t)
    return false,[] if t==1 or t==n
  }
end

ans = Set[]

(1..10_000_000).to_a.each do |n|
  found,memo = find_cycle(n, ans)
  if found
    # puts "#{n} => #{memo}"
    ans = ans.merge(memo)
  end
  puts "n=#{n}..." if n%100000==0
end
p ans.length
#p ans.all?{|e| found,_ = find_cycle(e,[]); found}
