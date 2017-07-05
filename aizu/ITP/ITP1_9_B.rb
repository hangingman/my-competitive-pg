#lines = <<'EOS'
#aabc
#3
#1
#2
#1
#vwxyz
#2
#3
#4
#-
#EOS

lines = $stdin.read #.split("\n")

next_is_times=true
cards=""

lines.split("\n").each do |line|

  if line == "-" then
    puts cards if cards != ""
    exit 0
  end

  if not /\A\d+\z/ === line then
    # aabc
    puts cards if cards != ""
    cards = line
    next_is_times = true
  elsif next_is_times then
    #puts line
    next_is_times = false
  else
    # number
    shuffle = line.to_i
    cards = "#{cards.slice(shuffle, cards.length + 1)}#{cards.slice(0, shuffle)}"

    # p cards.slice(shuffle, cards.length + 1)
    # p cards.slice(0, shuffle)
    #puts "#{shuffle} => #{cards}"
    #puts cards
  end
end
