# abc062 Dのデバッグ用スクリプト

require 'open3'

def call_rb(n, a, script)
  stdin, stdout, _, _ = Open3.popen3("ruby #{script}")
  stdin.puts n
  stdin.puts a.join(" ")
  stdin.close  # 忘れずに標準入力を閉じます
  output = stdout.read
  # 結果を出力します
  puts "#{output}     [#{script}]"

  return output
end

loop {
  n = rand(1..10**2)
  a = []
  1.upto(3*n) do |_|
    a << rand(1..10)
  end

  unless call_rb(n, a, "D_slow.rb").eql? call_rb(n, a, "D.rb")

    puts "---"
    puts n
    puts a.join(" ")

    break
  end
}
