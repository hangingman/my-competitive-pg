lines = $stdin.read

array = lines.chomp.downcase.each_codepoint.to_a
sum_h = (96..122).to_a.map{ |c| [c, 0]}.to_h
array.each{|i| sum_h[i] += 1 unless sum_h[i].nil? }

sum_h.sort.select{|k,v| 96 < k && k < 123 }.map do |k,v|
        puts "#{k.chr} : #{v}"
end
