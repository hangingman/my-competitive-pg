# coding: utf-8
#lines = <<'EOS'
#5
#EOS

lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

def shuffle_cards(n)
  i = 0
  cards = Array.new(6){i=i+1}
  for i in 0..(n-1)
    left  = i % 5 + 0
    right = i % 5 + 1
    cards[left], cards[right] = cards[right], cards[left]
  end
  puts cards.join
end

# 31周期で答えがループしている
shuffle_cards(N % 30)
