import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

// void call(int n){
//   int i = 1;
//  CHECK_NUM:
//   int x = i;
//   if ( x % 3 == 0 ){
//     cout << " " << i;
//     goto END_CHECK_NUM;
//   }
//  INCLUDE3:
//   if ( x % 10 == 3 ){
//     cout << " " << i;
//     goto END_CHECK_NUM;
//   }
//   x /= 10;
//   if ( x ) goto INCLUDE3;
//  END_CHECK_NUM:
//   if ( ++i <= n ) goto CHECK_NUM;
//
//   cout << endl;
// }

public class Main{

    static StringBuilder sb;

    public static void main(String[] args) {
    try {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        List<String> lines = new ArrayList<String>();

        for (String line = br.readLine(); line != null; line = br.readLine()) {
        lines.add(line);
        }
        //lines.add("60");
        br.close();

        Integer n = Integer.parseInt(lines.get(0));
        sb = new StringBuilder();

        for (int i = 1; i <= n; i++) {
        if (i%3==0) {
            sb.append(" " + i);
        } else if (i%10==3) {
            sb.append(" " + i);
        } else if (String.valueOf(i).contains("3")) {
            sb.append(" " + i);
        }
        }
        System.out.println(sb.toString());
        System.exit(0);

    } catch (Exception e) {
        System.out.println(e.getMessage());
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    }
    }
}
