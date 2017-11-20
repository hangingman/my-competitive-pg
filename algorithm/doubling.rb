def DT(where_to, n)

  src = where_to.dup
  dst = where_to.dup

  2.upto(n) do
    for i in (0...src.length).to_a
      dst[i] = src[dst[i]]
    end
  end
  dst
end

To = [1,2,3,4,0]

T1 = [
  To[0],
  To[1],
  To[2],
  To[3],
  To[4]
]

T2 = [
  T1[T1[0]],
  T1[T1[1]],
  T1[T1[2]],
  T1[T1[3]],
  T1[T1[4]],
]

T3 = [
  T1[T1[T1[0]]],
  T1[T1[T1[1]]],
  T1[T1[T1[2]]],
  T1[T1[T1[3]]],
  T1[T1[T1[4]]],
]

puts "-- -------------------- --"
puts "-- Show naive pattern!! --"
puts "-- -------------------- --"
puts T1.to_s
puts T2.to_s
puts T3.to_s
puts "-- -------------------- --"

puts "-- -------------------- --"
puts "-- Show doubling !      --"
puts "-- -------------------- --"
DT1 = DT(To.dup, 1)
puts DT1.to_s
DT2 = DT(To.dup, 2)
puts DT2.to_s
DT3 = DT(To.dup, 3)
puts DT3.to_s
