p3,p4,p5,p6,p7,p8 = [],[],[],[],[],[]

(1..10**5).each do |n|
  _p3 = n*(n+1)/2
  p3 << _p3 if 999 < _p3 and _p3 < 10000
  _p4 = n**2
  p4 << _p4 if 999 < _p4 and _p4 < 10000
  _p5 = n*(3*n-1)/2
  p5 << _p5 if 999 < _p5 and _p5 < 10000
  _p6 = n*(2*n-1)
  p6 << _p6 if 999 < _p6 and _p6 < 10000
  _p7 = n*(5*n-3)/2
  p7 << _p7 if 999 < _p7 and _p7 < 10000
  _p8 = n*(3*n-2)
  p8 << _p8 if 999 < _p8 and _p8 < 10000
end

@ans = []

def rec_search(arr, stack)

  if arr.empty?
    puts "#{stack} #{'<--- !!!' if stack.last.values[0].to_s[2,2] == stack.first.values[0].to_s[0,2]}"
    @ans = stack.dup if stack.last.values[0].to_s[2,2] == stack.first.values[0].to_s[0,2]
    return
  end

  arr.each do |k, v|
    matched = v.select{|val| stack.last.values[0].to_s[2,2] == val.to_s[0,2]}

    dup_arr = arr.dup
    dup_arr.delete(k)

    matched.each do |new_key|
      next if stack.any?{|stack_k, stack_v| stack_k==k}
      stack.push({k => new_key})
      puts "#{stack}"
      rec_search(dup_arr, stack)
      stack.pop()
    end
  end
end

arr = {p3: p3, p4: p4, p5: p5, p6: p6, p7: p7, p8: p8}
arr_dup = arr.dup
arr_dup.delete(:p3)

arr[:p3].each do |key|
  puts "#{{p3: key}}"
  rec_search(arr_dup, [].push({p3: key}))
end

puts "---"
p @ans
p @ans.map {|e| e.values[0]}.inject(&:+)
