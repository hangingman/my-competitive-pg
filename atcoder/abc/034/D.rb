INF = 10**5

class MaxAvg

  attr :n,:k,:w,:v,:y

  def initialize(n,k,w,v)
    @n=n
    @k=k
    @w=w.dup
    @v=v.dup
  end

  def C(x)
    # @w = water
    # @p = concentration
    #  sigma (@w*@p/100) / sigma (@w)
    #  sigma (@w*@p/100) / sigma (@w) >= x
    #  sigma (@w*@p/100 - x*@w) >= 0
    y=[]
    for i in 0...@n
      y[i] = (@w[i].to_f*@v[i].to_f).quo(100).to_f - (x * @w[i].to_f).to_f
      #y[i] = @v[i].to_f - (x * @w[i].to_f).to_f
    end
    y=y.sort
    #p y

    sum=0.to_f
    for i in 0...@k
      sum+=y[@n-i-1]
    end

    return sum>=0, y
  end

  def solve()
    lb,ub=0.to_f,INF.to_f
    for i in 0..100
      mid = (lb+ub).quo(2).to_f
      result,y = C(mid)
      if result
        lb = mid
      else
        ub = mid
      end
    end
    # p lb
    # p ub

    #puts "%.9f" % y.select{|n| n < 0}.inject(&:+).abs
    puts "%.9f" % (ub * 100)
  end
end

lines = <<'EOS'
3 2
100 15
300 20
200 30
EOS

#
# 100+300+200=600
# 15 => 15
# 20 => 60
# 30 => 60

#lines = $stdin.read
array = lines.split("\n")
N,K = array[0].split(" ").map(&:to_i)
w,p = [],[]
array[1...N+1].each do |str|
  w << str.split(" ")[0].to_i
  p << str.split(" ")[1].to_i
end

MaxAvg.new(N,K,w,p).solve()
