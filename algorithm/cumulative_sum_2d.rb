#
# http://tubo28.me/algorithm/cumulative_sum_2d/
# -----------------------------------------------------------------------------
# template <class T>
# std::vector<std::vector<T>> Imos2D(const std::vector<std::vector<T>>& a) {
#     int h = a.size(), w = a[0].size();
#     std::vector<std::vector<T>> s(h + 1, std::vector<T>(w + 1, 0));
#     rep(i, h) rep(j, w) s[i + 1][j + 1] = a[i][j];
#     rep(i, h + 1) rep(j, w) s[i][j + 1] += s[i][j];
#     rep(i, h) rep(j, w + 1) s[i + 1][j] += s[i][j];
#     return s;
# }
#
# template <class T>
# int sum(const std::vector<std::vector<T>>& s, int i, int j, int h, int w) {
#     return s[i + h][j + w] - s[i][j + w] + s[i][j] - s[i + h][j];
# }

def imos_2d(a)
  h,w = a.length,a.first.length
  s = Array.new(h+1).map{Array.new(w+1,0)}
  for i in 0...h
    for j in 0...w
      s[i+1][j+1] = a[i][j]
    end
  end
  for i in 0...h+1
    for j in 0...w
      s[i][j+1] += s[i][j]
    end
  end
  for i in 0...h
    for j in 0...w+1
      s[i+1][j] += s[i][j]
    end
  end
  s
end

def sum(s,i,j,h,w)
  s[i+h][j+w] - s[i][j+w] + s[i][j] - s[i+h][j]
end

test1 = Array.new(3).map{Array.new(3,0)}
test1 = [[1,1,1],[0,0,0],[0,0,0]]

s = imos_2d(test1)
p s
