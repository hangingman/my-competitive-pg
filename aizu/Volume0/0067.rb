lines = <<'EOS'
111100001111
111000001111
110000001111
100000001111
000100010000
000000111000
000001111100
100011111110
110001111100
111000111000
111100010000
000000000000

010001111100
110010000010
010010000001
010000000001
010000000110
010000111000
010000000100
010000000010
010000000001
010010000001
010010000010
111001111100

000000000000
111111111111
100010100001
100010100001
100010100001
100010100001
100100100101
101000011101
100000000001
100000000001
111111111111
100000000001
EOS

#lines = $stdin.read
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

    #dxy = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
    dxy = [[-1,0],[0,-1],[0,1],[1,0]]
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

  if array[i]==''
    i+=1
    next
  end

  m = Array.new(12).map{Array.new(12,0)}
  array[i...i+12].each_with_index do |line,idx|
    m[idx] = line.split("").map(&:to_i)
  end

  dfs,ans = Dfs.new(m),0

  for y in 0...12
    for x in 0...12
      # puts "x=#{x},y=#{y}"
      if dfs.mat[x][y]==1
        dfs.inc = dfs.inc + 1
        dfs.dfs(x,y)
      end
    end
  end

  #dfs.mat.each{|r| p r}
  #puts ""

  ans = dfs.mat.map(&:max).max-1
  ans = if ans<0
          0
        else
          ans
        end
  puts ans

  i+=(12+1)
end
