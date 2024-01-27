lines = <<'EOS'
7 1
100 10 1
ssssppr
EOS

#lines = $stdin.read
array = lines.split("\n")
N,K = array[0].split(" ").map(&:to_i)
R,S,P = array[1].split(" ").map(&:to_i)
T = array[2].split("")

ans = 0
before_hands = {}

def victory(t)
  hand, score = case t
                when 'r' then
                  ['p', P]
                when 'p' then
                  ['s', S]
                when 's' then
                  ['r', R]
                end
  return hand, score
end


T.each_with_index do |t, idx|
  group = idx % K
  hand, score = victory(t)

  before_hand = before_hands[group]
  if before_hand.nil? or before_hand != hand
    ans += score
    before_hands[group] = hand
  else
    hand = if T[idx+K].nil?
             t
           else
             all = ['p', 's', 'r']
             next_hand = victory(T[idx+K])
             all.reject{ |h| h==before_hand and h==next_hand}
           end
    before_hands[group] = hand
  end
end

puts ans
