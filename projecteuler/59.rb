# coding: utf-8
def xor(eq1, eq2)
  eq1 ^ eq2
end

words = []
File.open("p059_cipher.txt", "r") do |f|
  words = f.read.split(",").map(&:to_i)
end

("a".."z").to_a.repeated_permutation(3) do |keys|
  decrypted = []

  words.each_slice(3) do |encrypted|
    encrypted.zip(keys).map do |enc, key|
      decrypted << xor(enc, key.ord)
    end
  end

  if decrypted.all?{|n| n >= 32}
    p keys
    puts decrypted.join[0, 20]

    if decrypted.map{|n| n.chr}.join.include?("the")
      puts decrypted.map{|n| n.chr}.join
      puts ""
    end
  end
end

# 上記で ["e", "x", "p"] が鍵であるとわかる
