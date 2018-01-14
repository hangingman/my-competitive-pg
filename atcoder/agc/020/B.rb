lines = <<'EOS'
4
3 4 3 2
EOS

#lines = $stdin.read
array = lines.split("\n")

# A = array[1].split(" ").map(&:to_i)
# K = array[0].to_i

A = array[1].split(" ").map(&:to_i).sort
K = A.length

possibles = [2]

begin

  K.downto(1) do |i|

    # remove impossible values
    possibles.reject! do |a|
      a < A[i-1] or a % A[i-1] != 0
    end

    puts "#{i} => class #{A[i-1]} bef: #{possibles}"

    # select max before value
    max_bef = A[i-1]

    count = 1
    while max_bef <= possibles.max
      max_bef = A[i-1] * count
      count += 1
    end

    possibles << (possibles.max...max_bef).to_a
    possibles.flatten!.uniq!

    puts "#{i} => class #{A[i-1]} aft: #{possibles}"
  end
rescue
  puts -1
  exit 0
end

puts "#{possibles.min} #{possibles.max}"
