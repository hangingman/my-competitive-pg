lines = <<'EOS'
CODEFESTIVALFESTIVAL
EOS

#lines = $stdin.read
array = lines.split("\n")

puts array[0].to_s.gsub(/FESTIVAL$/, '')
