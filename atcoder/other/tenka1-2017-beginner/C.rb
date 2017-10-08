lines = <<'EOS'
9 30
22
5
2
18
6
21
29
11
18
EOS

#lines = $stdin.read
array = lines.split("\n")

N,C = array[0].split(" ").map(&:to_i)
pipes = array[1..N].map(&:to_i)
pipes.sort!.reverse!

def rm_pairs_ceil(pipes, pair_count)
  puts pipes.to_s

  idx = pipes[0...pipes.length-1].find_index do |pipe|
    pipe + pipes.last + 1 <= C
  end

  unless idx.nil?
    puts "pair ! #{pipes[idx]}, #{pipes[pipes.length-1]}"
    pair_count += 1
    puts "pairs = #{pair_count}"
    pipes.delete_at(idx)
    pipes.delete_at(pipes.length-1)
    pair_count = rm_pairs_ceil(pipes, pair_count)
  end

  pair_count
end

pair_count = rm_pairs_ceil(pipes, 0)
puts pair_count + pipes.length
