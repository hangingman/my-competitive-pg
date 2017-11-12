lines = <<'EOS'
3
2
4
8
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
C = array[1..N].map(&:to_i)

coins = C.permutation(N).map do |arr|
  arr
end

coins = coins.map do |coin|
  coin_tmp = coin.dup

  for i in 0..coin.length
    #puts "coin = #{coin}"
    coin_tmp.each_with_index do |sub_coin, index|
      if index > i
        #puts "  coin_tmp = #{coin_tmp}"
        #puts "  index_coin = #{coin_tmp[i]}, sub_coin = #{sub_coin}"
        if sub_coin % coin_tmp[i] == 0 and coin_tmp[i].abs <= sub_coin.abs
          coin_tmp[index] = coin_tmp[index]*-1
        end
      end
    end
  end
  #puts "=> #{coin_tmp}"
  coin_tmp
end

ans = coins.map do |line|
  line = line.map do |c|
    if c < 0
      0
    else
      1
    end
  end
  line.inject(:+)
end

printf "%.12f\n",(ans.inject(:+).to_f / ans.length.to_f).to_f.round(12)
