lines = <<'EOS'
101
EOS

#lines = $stdin.read
array = lines.split("\n")

count = array[0].split("").count{|s| s=='1'}
puts count
