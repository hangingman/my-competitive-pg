# coding: utf-8
require 'nokogiri'
require 'open-uri'

def get_problem(url)
    html = open(url)
    doc = Nokogiri::HTML.parse(html, nil, "UTF-8")

    # 問題タイトル
    nodesets = doc.xpath('//h2')
    title = nodesets.text.gsub(/.*「(.*)」.*/, '「\1」')
    # 問題文
    nodesets = doc.xpath('//p')
    content = nodesets.text
    return title,content
end

N = $stdin.read.to_i

puts "{{category プロジェクト・オイラー}}"
puts ""
puts "!!! プロジェクト・オイラー(#{N.to_s.rjust(3,'0')}-#{(N+4).to_s.rjust(3,'0')})"
puts ""
for n in N..N+4

    title,content = get_problem("http://odz.sakura.ne.jp/projecteuler/index.php?cmd=read&page=Problem%20#{n}")

    puts "!! [Problem #{n}|http://odz.sakura.ne.jp/projecteuler/index.php?cmd=read&page=Problem%20#{n}]"
    puts "! [Probem|https://projecteuler.net/problem=#{n}] #{title}"
    puts ""
    content.split("\n").each do |line|
      puts "  #{line}"
    end
    puts ""
    puts "! Answer"
    puts ""
    puts "{{layout roll,title:解答"
    puts "* 考えたこと"
    puts "{{list"
    puts "}}"
    puts "}}"
    puts ""
end
