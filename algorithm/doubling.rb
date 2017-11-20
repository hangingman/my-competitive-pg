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

T4 = [
  T1[T1[T1[T1[0]]]],
  T1[T1[T1[T1[1]]]],
  T1[T1[T1[T1[2]]]],
  T1[T1[T1[T1[3]]]],
  T1[T1[T1[T1[4]]]],
]

puts "-- -------------------- --"
puts "-- Show naive pattern!! --"
puts "-- -------------------- --"
puts T1.to_s
puts T2.to_s
puts T3.to_s
puts T4.to_s
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
DT4 = DT(To.dup, 4)
puts DT4.to_s

DT64 = DT(To.dup, 64)
puts DT64.to_s
DT121 = DT(To.dup, 121)
puts DT121.to_s

puts "-- -------------------- --"
puts "-- Show 'magic' !       --"
puts "-- -------------------- --"

EDT1 = DT(To.dup, 1)
puts EDT1.to_s
EDT2 = DT(To.dup, 2)
puts EDT2.to_s
EDT4 = DT(EDT2.dup, 2)
puts EDT4.to_s

EDT8 = DT(EDT4.dup, 2)
#puts EDT8.to_s
EDT64 = DT(EDT8.dup, 8)
#puts EDT64.to_s

EDT11  = DT(To.dup, 11)
EDT121 = DT(EDT11.dup, 11)
puts EDT121.to_s
