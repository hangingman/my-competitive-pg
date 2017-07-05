#lines = [
#"123",
#"55",
#"1000",
#"0"
#]

lines = $stdin.read.split("\n")

lines.each do |l|
    exit 0 if l == "0"
    puts l.split("").inject(0){|sum, i| sum + i.to_i }
end
