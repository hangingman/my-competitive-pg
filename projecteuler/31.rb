# coding: utf-8
#
# There are 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
# -------------------------------------------------------------
#
# $ time ruby 31.rb
# 73682
#
# real    0m3.901s
# user    0m0.000s
# sys     0m0.015s
#
# -------------------------------------------------------------

#        a, b, c, d , e , f , g  , h
COINS = [1, 2, 5, 10, 20, 50, 100, 200]
#        0, 1, 2,  3,  4,  5,   6,   7
ans   = []
sum   = 0

def sum_coin(h=0,g=0,f=0,e=0,d=0,c=0,b=0,a=0)
  a*1 + b*2 + c*5 + d*10 + e*20 + f*50 + g*100 + h*200
end

for h in 0..200/COINS[7]
  next if sum_coin(h) > 200
  for g in 0..200/COINS[6]
    next if sum_coin(h,g) > 200
    for f in 0..200/COINS[5]
      next if sum_coin(h,g,f) > 200
      for e in 0..200/COINS[4]
        next if sum_coin(h,g,f,e) > 200
        for d in 0..200/COINS[3]
          next if sum_coin(h,g,f,e,d) > 200
          for c in 0..200/COINS[2]
            next if sum_coin(h,g,f,e,d,c) > 200
            for b in 0..200/COINS[1]
              next if sum_coin(h,g,f,e,d,c,b) > 200
              for a in 0..200/COINS[0]
                sum = sum_coin(h,g,f,e,d,c,b,a)
                next if sum > 200
                if sum == 200
                  # puts "#{a},#{b},#{c},#{d},#{e},#{f},#{g},#{h}"
                  ans << "a = #{a},b = #{b},c = #{c},d = #{d},e = #{e},f = #{f},g = #{g},h = #{h}"
                end
              end
            end
          end
        end
      end
    end
  end
end

puts ans.length
