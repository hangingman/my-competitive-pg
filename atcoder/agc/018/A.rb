# coding: utf-8
require 'set'

#lines = <<'EOS'
#3 5
#6 9 3
#EOS

lines = <<'EOS'
3 7
9 3 4
EOS

#lines = $stdin.read
array = lines.split("\n")

N,K = array[0].split(" ").map(&:to_i)
arr = array[1].split(" ").map(&:to_i)

def recursive_gen_diff(arr)
  arr_cp = arr.dup

  cmb = arr.combination(2)
  cmb.each do |e|
    #puts "#{e.to_s} = #{(e[0]-e[1]).abs}"
    arr_cp.push((e[0]-e[1]).abs)
  end

  arr_cp = arr_cp.sort.reverse.uniq

  if arr_cp.size == arr.size
    return arr_cp
  else
    recursive_gen_diff(arr_cp)
  end
end


# Nが箱の中のボールの数
# Kが戻したいボールについた番号

#
# 3 7
# 9 3 4
#
# [9 - 4].abs = 5
# [3 - 5].abs = 2
# [9 - 2].abs = 7
if arr.include? K
  puts "POSSIBLE"
else
  if arr.max < K
    puts "IMPOSSIBLE"
  else
    arr = arr.sort.reverse.uniq
    cmb_arr = recursive_gen_diff(arr)
    if cmb_arr.size > arr.size
      puts "POSSIBLE"
    else
      puts "IMPOSSIBLE"
    end

    #puts cmb_arr.to_s
    #if cmb_arr.combination(2).find {|a, b| a + b == K }
    #  puts "POSSIBLE"
    #else
    #  puts "IMPOSSIBLE"
    #end
  end
end
