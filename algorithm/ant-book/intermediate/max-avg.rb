# n = 3
# k = 2
# (w,v) ={2,2},{5,3},{2,1}

INF = 10**5

class MaxAvg

  attr :n,:k,:w,:v,:y

  def initialize(n,k,w,v)
    @n=n
    @k=k
    @w=w.dup
    @v=v.dup
    @y=[]
  end

  def C(x)
    for i in 0...@n
      @y[i] = @v[i] - x*@w[i]
    end
    @y=@y.sort.reverse
    p @y
    sum=0
    for i in 0...@k
      sum+=@y[n-i-1]
    end
    sum>=0
  end

  def solve()
    lb,ub=0,INF
    for i in 0..100
      mid = (lb+ub)/2
      if C(mid)
        lb = mid
      else
        ub = mid
      end
    end
    puts "%.2f" % ub
  end
end

ma = MaxAvg.new(3,2,[2,5,2],[2,3,1])
ma.solve()
