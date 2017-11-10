lines = <<'EOS'
90 30
EOS

#lines = $stdin.read
array = lines.split("\n")

N,X = array[0].split(" ").map(&:to_i)

blocks = Array.new(N, '_')
blocks[X-1] = '#'
#puts blocks.to_s

left_d  = (1-X).abs
right_d = (N-X).abs

ans = if left_d <= right_d
        left_d
      else
        right_d
      end

puts ans
