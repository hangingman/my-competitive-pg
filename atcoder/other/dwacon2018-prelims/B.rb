lines = <<'EOS'
2255252252222555552522255255
EOS

#lines = $stdin.read
array = lines.split("\n")
S = array[0].split("")

max_dp = 0
stack  = []
d      = ""

unless S.count{|s| s == "2"} == S.count{|s| s == "5"}
  puts "-1"
  exit 0
end

S.each do |c|

  max_dp = stack.size if max_dp < stack.size

  if c == "2"
    stack.push(c)
  elsif c == "5"
    d = stack.pop
    if d != "2"
      puts "-1"
      exit 0
    end
  end
end

puts max_dp
