lines = $stdin.read

array = lines.split("\n")

str = array[0]
n   = array[1]

for i in 2..(1+n.to_i)
  command = array[i].split(" ")[0]
  a = array[i].split(" ")[1].to_i
  b = array[i].split(" ")[2].to_i

  if command == "replace"
    str[a..b] = array[i].split(" ")[3]
  elsif command == "reverse"
    r = str[a..b].reverse
    len = str.length
    if a == 0
      str = "#{r}#{str[b+1..len]}"
    elsif b == 0
      str = "#{str[0..a-1]}#{r}"
    else
      res1 =
      str = "#{str[0..a-1]}#{r}#{str[b+1..len]}"
    end
  elsif command == "print"
    puts str[a..b]
  end
end
