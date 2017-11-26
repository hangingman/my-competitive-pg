puts 100.downto(1).inject(:*).to_s.split("").map(&:to_i).inject(&:+)
