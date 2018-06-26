//
// Thanks https://beta.atcoder.jp/contests/abc038/submissions/2739642
// fumiphys
//

#include <iostream>
#include <vector>
#include <utility>
#include <algorithm>
#include <cmath>
#define INF 100000000

using namespace std;
typedef pair<int, int> P;

//
// g++ D.cpp -o D && cat STDIN.txt | ./D
//
bool comp(P a, P b){
  if(a.first != b.first)return a.first < b.first;
  else return a.second > b.second;
}

int main(int argc, char const* argv[])
{
  int n;
  cin >> n;
  vector<P> vec;
  for(int i = 0; i < n; i++){
    int w, h;
    cin >> w >> h;
    vec.push_back(make_pair(w, h));
  }
  sort(vec.begin(), vec.end(), comp);

  int *dp = new int[n];
  fill(dp, dp+n, INF);

  for(int i = 0; i < n; i++){
    cout << "vec[i].second:" << vec[i].second << endl;
    *lower_bound(dp, dp+n, vec[i].second) = vec[i].second;
    for (int j = 0; j < n; j++){
      cout << "dp[" << j << "]:" << dp[j] << endl;
    }
  }
  cout << lower_bound(dp, dp+n, INF) - dp << endl;
  return 0;
}
