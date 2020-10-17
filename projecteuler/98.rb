File.open("words.txt", "r") do |f|
  s = f.read.gsub(/\"/, "")

  len_word_hash = {}
  
  s.split(",").each do |word|
    # puts word
    if len_word_hash.has_key?(word.length)
      len_word_hash[word.length()] << word
    else
      len_word_hash[word.length()] = [word]
    end
  end


  anagrams = []
  len_word_hash.each do |len,words|

    sorted_words = words.map do |word|
      "#{word.split("").sort!.join},#{word}"
    end.sort

    sorted_words.each_cons(2) do |cons|
      if cons[0].split(",").first==cons[1].split(",").first
        anagram_l = cons[0].split(",")[1]
        anagram_r = cons[1].split(",")[1]
        # puts anagram_l + "," + anagram_r
        anagrams << "#{anagram_l},#{anagram_r}"
      end
    end
  end

  anagrams.each do |a|
    anagram_len = a.split(",").first.length
    connect = a.gsub(/,/, "").split("").uniq.sort.join
    p connect
    p a

    (0..9).to_a.permutation(anagram_len) do |pattern|
      tmp = a.dup
      connect.split("").each_with_index{|alpha,i| tmp.gsub!(/#{alpha}/, pattern[i].to_s)}

      left, right = tmp.split(",").map(&:to_i)
      sqrt_l, sqrt_r = Math.sqrt(left), Math.sqrt(right)
      if left.to_s.length==anagram_len and
        right.to_s.length==anagram_len and
        sqrt_l - sqrt_l.to_i == 0 and
        sqrt_r - sqrt_r.to_i == 0
        puts "=> #{pattern.to_a} -> #{left},#{right}"
      end
    end
  end
end
