# lines = <<'EOS'
# 1 1
# 0
# 2 2
# 0 1
# 1 0
# 3 2
# 1 1 1
# 1 1 1
# 5 4
# 1 0 1 0 0
# 1 0 0 0 0
# 1 0 1 0 1
# 1 0 0 1 0
# 5 4
# 1 1 1 0 1
# 1 0 1 0 1
# 1 0 1 0 1
# 1 0 1 1 1
# 5 5
# 1 0 1 0 1
# 0 0 0 0 0
# 1 0 1 0 1
# 0 0 0 0 0
# 1 0 1 0 1
# 0 0
# EOS

lines = $stdin.read
array = lines.split("\n")

class Dfs
  attr_accessor :mat,:inc

  def initialize(mat)
    @mat = mat.dup
    @inc = 1
  end

  def dfs(x,y)

    @mat[x][y] = @inc if @mat[x][y] == 1

    #@mat.each{|r| p r}

    dxy = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
    for i in 0...dxy.length
      dx,dy = dxy[i].first,dxy[i].last
      nx,ny = x+dx,y+dy
      if 0<=nx and nx<@mat.length and 0<=ny and ny<@mat.first.length
        dfs(nx,ny) if @mat[nx][ny]==1
      end
    end

  end
end

# 0=sea,1=island

i = 0
until array[i].nil?
  w,h = array[i].split(" ").map(&:to_i)
  exit 0 if w==0 and h==0

  # puts "w=#{w},h=#{h}"
  m = Array.new(h).map{Array.new(w,0)}
  array[i+1...i+h+1].each_with_index do |line,idx|
    m[idx] = line.split(" ").map(&:to_i)
  end

  dfs,ans = Dfs.new(m),0

  for y in 0...w
    for x in 0...h
      # puts "x=#{x},y=#{y}"
      if dfs.mat[x][y]==1
        dfs.inc = dfs.inc + 1
        dfs.dfs(x,y)
      end
    end
  end

  #dfs.mat.each{|r| p r.max}
  #puts ""

  ans = dfs.mat.map(&:max).max-1
  ans = if ans<0
          0
        else
          ans
        end
  puts ans

  i+=(h+1)
end
