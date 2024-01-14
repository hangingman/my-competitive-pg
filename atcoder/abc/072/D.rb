lines = <<'EOS'
9
1 2 3 9 5 8 7 4 6
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
P = array[1].split(" ").map(&:to_i)

def count_correct_pairs(arr)
  count = 0
  i = 0

  while i < arr.length
    unless arr[i+1].nil?
      if arr[i]==(i+1) and arr[i+1]==(i+2)
        count += 1
        i += 2 # ペアをスキップ
        next
      end
    end

    if arr[i] == (i+1)
      count += 1
    end
    i += 1
  end

  count
end

# テスト
#ans = count_correct_pairs([1, 4, 3, 5, 2]) # => 2
#puts "==="
#puts ans

#ans = count_correct_pairs([1, 2, 3, 5, 4]) # => 1
#puts "==="
#puts ans

#ans = count_correct_pairs([1, 2, 3, 4])    # => 2
#puts "==="
#puts ans

puts count_correct_pairs(P)
