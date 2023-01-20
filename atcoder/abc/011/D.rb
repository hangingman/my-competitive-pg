lines = <<'EOS'
11 8562174
25686522 17124348
EOS

#lines = $stdin.read
array = lines.split("\n")

N,D = array[0].split(" ").map(&:to_i)
x,y = array[1].split(" ").map(&:to_i)

if (x%D != 0 || y%D !=0)
  puts 0.0
  exit 0
end

X,Y = array[1].split(" ").map(&:to_i).map{|n| n/D}
MAX_N=1000

class Combination
  attr_reader :comb

  def initialize
    @comb = Array.new(MAX_N+1).map{Array.new(MAX_N+1, 0.to_f)}
    @comb[0][0] = 1.to_f

    for i in 0...MAX_N
      for j in 0...MAX_N
        #puts "i=#{i},j=#{j}"
        #puts "---"
        @comb[i+1][j+1] += @comb[i][j].quo(2).to_f
        @comb[i+1][j] += @comb[i][j].quo(2).to_f
      end
    end
  end

  def prob(n,r)
    @comb[n][r]
  end
end

@c = Combination.new
ans = 0

for a in 0..N
  b = N - a
  # puts "x move: #{a}, y move: #{b}"
  # puts "(a+X)%2 = #{(a+X)%2}"
  # puts "(b+Y)%2 = #{(b+Y)%2}"
  next if (a+X)%2 == 1 || (b+Y)%2 == 1

  #puts "a=#{a},b=#{b},X=#{X},Y=#{Y}"
  #puts "---"
  r=(a + X).quo(2)
  l=(a - r)
  u=(b + Y).quo(2)
  d=(b - u)

  next if r<0 or l<0 or u<0 or d<0
  # p "r:#{r},l:#{l}"
  # p "u:#{u},d:#{d}"
  # p "@c.prob(#{N},#{a}) = #{@c.prob(N,a)}"
  # p "@c.prob(#{a},#{r}) = #{@c.prob(a,r)}"
  # p "@c.prob(#{b},#{u}) = #{@c.prob(b,u)}"

  tmp = @c.prob(N,a) * @c.prob(a,r.to_i) * @c.prob(b,u.to_i)
  # p "tmp = #{tmp}"
  ans += tmp
end

printf("%.10f\n", ans.to_f)
