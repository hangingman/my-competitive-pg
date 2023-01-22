

def detect_pandigital(digit_arr)
  is_pandigital = nil
  begin
    eval("is_pandigital = (#{digit_arr.join})")
  rescue SyntaxError
  end

  if is_pandigital
    p "ans = (#{digit_arr.join})"

    formula = digit_arr.join
    l,r = formula.split("==")
    product = l.include?('*') ? r : l
    tmp = l.include?('*') ? l : r
    small,large = tmp.split('*').min,tmp.split('*').max
    return product,small,large
  end

  [nil,nil,nil]
end

ans = {}
pandigitals = ('1'..'9').to_a + ['*', "=="]
pandigitals.permutation(11).with_index(0) do |result,index|
  prod,small,large = detect_pandigital(result)

  if prod!=nil
    ans.merge!({prod => [small, large]})
  end
end

p ans
p ans.map{|k,v| k.to_i}.inject(&:+)
