lines = <<'EOS'
zzz
zzz
EOS

#lines = $stdin.read
array = lines.split("\n")
s = array[0]
t = array[1]

# first
s_dash = s.split("").sort.join
# latter
t_dash = t.split("").sort.reverse.join

len = 0

while true
  #p s_dash.length
  #p t_dash.length
  #p len
  if s_dash.length <= len or t_dash.length <= len
    if s_dash.length < t_dash.length
      puts "Yes"
    else
      puts "No"
    end
    exit 0
  else
    if s_dash[len] == t_dash[len]
    else
      if s_dash[len] > t_dash[len]
        puts "No"
      else
        puts "Yes"
      end
      exit 0
    end
  end
  len += 1
end
