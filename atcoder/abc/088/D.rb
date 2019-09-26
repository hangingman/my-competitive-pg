# coding: utf-8
lines = <<'EOS'
10 37
.....................................
...#...####...####..###...###...###..
..#.#..#...#.##....#...#.#...#.#...#.
..#.#..#...#.#.....#...#.#...#.#...#.
.#...#.#..##.#.....#...#.#.###.#.###.
.#####.####..#.....#...#..##....##...
.#...#.#...#.#.....#...#.#...#.#...#.
.#...#.#...#.##....#...#.#...#.#...#.
.#...#.####...####..###...###...###..
.....................................
EOS

# lines = $stdin.read
array = lines.split("\n")
INF = 10**9
H,W = array[0].split(" ").map(&:to_i)
@d = Array.new(50).map{Array.new(50, INF)}
DX = [1,0,-1,0]
DY = [0,1,0,-1]

@maze = Array.new(H).map{Array.new(W, "")}
array[1..H].each_with_index do |line,i|
  @maze[i] = line.split("")
end

black = @maze.map{|line| line.count{|e| e=="#"}}.inject(&:+)

def bfs(sx,sy,gx,gy)
  @que = []
  @que.push([sx,sy])
  @d[sx][sy] = 1

  while not @que.empty?
    p = @que.shift()
    x = p[0]
    y = p[1]
    break if x==gx and y==gy

    for i in 0..3
      nx = x+DX[i]
      ny = y+DY[i]

      if 0<=nx and
        nx<H and
        0<=ny and
        ny<W and
        @maze[nx][ny] != '#' and
        @d[nx][ny] == INF

        # puts "#{nx},#{ny}"
        # @maze.each_with_index do |line,i|
        #   line.each_with_index do |e,j|
        #     if i==nx and j==ny
        #       printf("+")
        #     else
        #       printf(e)
        #     end
        #   end
        #   puts ""
        # end
        # puts "---"

        @que.push([nx,ny])
        @d[nx][ny] = @d[x][y]+1
      end
    end
  end
  @d[gx][gy]
end

dist = bfs(0,0,H-1,W-1)
ans = H*W - black - dist

if ans < 0
  puts "-1"
else
  puts ans
end
