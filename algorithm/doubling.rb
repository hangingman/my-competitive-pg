# coding: utf-8
N = 6                      # 全体の要素数
LOG_N = Math.log2(N).floor # log2(N)

# next_obj[k][i]で、i番目の要素の「2^k個次の要素」を指す
# (なお、i番目の要素に対して「2^k個次の要素」が存在しないとき、
#  next_obj[k][i]が指し示す要素番号を-1とします)
next_obj = Array.new(LOG_N+1).map{Array.new(N, 0)}

# next_obj[0]を計算
for i in 0...N
  next_obj[0][i] = (iの次の要素)
end

# nextを計算
for k in 0...LOG_N
  for i in i...N
    if next_obj[k][i] == -1
      # 2^k個次に要素が無い時、当然2^(k+1)個次にも要素はありません
      next_obj[k+1][i] = -1
    else
      # 「2^k個次の要素」の2^k個次の要素は、2^(k+1)個次の要素です
      next_obj[k+1] = next_obj[k][next_obj[k][i]]
    end
  end
end

# ----ここまで準備----


# p番目の要素の「Q個次の要素」を求めることを考えます
k = LOG_N -1
until k >= 0
  # pがすでに存在しない要素を指していたら、
  # それ以降で存在する要素を指すことはないためループを抜けます
  break if p == -1

  if ((Q >> k) & 1)
    # Qを二進展開した際、k番目のビットが立っていたら、
    # pの位置を2^kだけ次にずらします
    p = next_obj[k][p]
  end
  k-=1
end
