lines = <<'EOS'
133
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

def convert_to_special_base5(n)
  convert_numbers = [0, 2, 4, 6, 8]
  return '0' if n==0

  result = ''
  while n > 0
    result = "#{convert_numbers[n % 5]}#{result}"
    n /= 5
  end

  return result
end

puts convert_to_special_base5(N-1)
