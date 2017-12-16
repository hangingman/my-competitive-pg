lines = <<'EOS'
FF
1 0
EOS

#lines = $stdin.read
array = lines.split("\n")
S   = array[0]
X,Y = array[1].split(" ").map(&:to_i)

def backtrack(path,src,dst,direct)
  #p path
  #p src
  #p dst
  #p direct

  if path.empty?
    if src == dst
      #puts "result true!"
      #puts ""
      #true
      puts "Yes"
      exit 0
    else
      #puts "result false!"
      #puts ""
      false
    end
  else
    d = path.shift
    if d == 'T'
      case direct
      when :right then
        #puts "right"
        backtrack(path.dup,src,dst,:up)
        backtrack(path.dup,src,dst,:down)
      when :left then
        #puts "left"
        backtrack(path.dup,src,dst,:up)
        backtrack(path.dup,src,dst,:down)
      when :up then
        #puts "up"
        backtrack(path.dup,src,dst,:left)
        backtrack(path.dup,src,dst,:right)
      when :down then
        #puts "down"
        backtrack(path.dup,src,dst,:left)
        backtrack(path.dup,src,dst,:right)
      end
    else
      case direct
      when :right then
        backtrack(path,[src.first+1,src.last],dst,:right)
      when :left then
        backtrack(path,[src.first-1,src.last],dst,:left)
      when :up then
        backtrack(path,[src.first,src.last+1],dst,:up)
      when :down then
        backtrack(path,[src.first,src.last-1],dst,:down)
      end
    end
  end
end

if S.split("").count{|c| c == 'F'} < X+Y
  puts "No"
else
  unless backtrack(S.split(""),[0,0],[X,Y],:right)
    puts "No"
  end
end
