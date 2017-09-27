#lines = <<'EOS'
#567914
#EOS

lines = $stdin.read
array = lines.split("\n")
n = array[0].to_i

start_time = Time.now

def tribonacci(n)
  if n == 1 or n == 2
    0
  elsif n == 3
    1
  else
    t0 = 0
    t1 = 0
    t2 = 1
    tn = 0
    4.upto(n) do
      tn = (t0 + t1 + t2) % 10007
      t0,t1,t2 = t1,t2,tn
    end
    tn
  end
end

puts tribonacci(n)

#p "Elasped #{Time.now - start_time}s"
