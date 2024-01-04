lines = <<'EOS'
10
3 1 4 1 5 9 2 6 5 3
EOS

#lines = $stdin.read
array = lines.split("\n")

def lis(arr)
  tail = Array.new(arr.length)
  len = 1

  one = arr.find_index{|e| e==1}
  if one==nil
    puts "-1"
    exit 0
  end

  tail[0] = arr[one]

  for i in one...arr.length
    if arr[i] < tail[0]
      tail[0] = arr[i]
    elsif arr[i] == tail[len-1] + 1
      tail[len] = arr[i]
      len = len + 1
    else
      # NOP
    end
  end
  len
end

n = array[0].to_i
a = array[1].split(" ").map(&:to_i)
puts n - lis(a)
