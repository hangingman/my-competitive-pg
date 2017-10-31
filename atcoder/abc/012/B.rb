lines = <<'EOS'
3661
EOS

#lines = $stdin.read
array = lines.split("\n")

sec = array[0].to_i

hh = sec / 3600
mm = (sec - 3600 * hh) / 60
ss = sec - (3600 * hh) - (60 * mm)

printf "%02d:%02d:%02d\n",hh,mm,ss
