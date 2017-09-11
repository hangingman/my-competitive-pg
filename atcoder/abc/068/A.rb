lines = <<'EOS'
38
EOS

#lines = $stdin.read
array = lines.split("\n")

printf "ABC%03d\n", array[0].to_i
