lines = <<'EOS'
81
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i

40000.downto(0) do |i|
  pow = i*i
  if pow <= N
    puts pow
    break
  end
end
