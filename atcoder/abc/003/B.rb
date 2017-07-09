lines = $stdin.read
array = lines.split("\n")

S = array[0].to_s
T = array[1].to_s

if S.length != T.length
  puts "You will lose"
  exit
end

if !S.include?('@') and !T.include?('@')
  if S == T
    puts "You can win"
  else
    puts "You will lose"
  end
  exit
end

for i in 0...(S.length)

  if S[i] == T[i]
    next
  else
    if S[i] == "@" and "atcoder".include?(T[i])
      next
    elsif T[i] == "@" and "atcoder".include?(S[i])
      next
    else
      puts "You will lose"
      exit
    end
  end
end
puts "You can win"
