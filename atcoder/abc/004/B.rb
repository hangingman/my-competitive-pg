#lines = <<'EOS'
#. . . .
#. x x .
#. x o .
#. . . .
#EOS

lines = $stdin.read
array = lines.split("\n")

cols = array[0].split(" ").length
rows = array.length

c = Array.new(rows).map{Array.new(cols,0)}

#puts c.to_s

for row in 0...rows
  line = array[row]
  for col in 0...cols
    c[row][col] = line.split(" ")[col]
  end
end

(rows-1).downto(0) do |row|
  (cols-1).downto(0) do |col|
    if col != 0
      printf "#{c[row][col]} "
    else
      printf "#{c[row][col]}\n"
    end
  end
end
