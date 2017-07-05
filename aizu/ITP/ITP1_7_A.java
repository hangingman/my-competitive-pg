import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Main{

    static StringBuilder sb;

    public static void main(String[] args) {
    try {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        List<String> lines = new ArrayList<String>();
        String line = "";

        while((line = br.readLine()) != null){
            lines.add(line);
        }
        br.close();

        //lines.add("40 42 -1");
        //lines.add("20 30 -1");
        //lines.add("0 2 -1");
        //lines.add("-1 -1 -1");

        for (int i = 0; i < lines.size(); i++) {
        Integer m = Integer.parseInt(lines.get(i).split(" ")[0]);
        Integer f = Integer.parseInt(lines.get(i).split(" ")[1]);
        Integer r = Integer.parseInt(lines.get(i).split(" ")[2]);

        if (m == -1 && f == -1 && r == -1) {
            System.exit(0);
        } else if (m == -1 || f == -1) {
            System.out.println("F");
        } else if (m+f >= 80) {
            System.out.println("A");
        } else if (65 <= m+f && m+f < 80) {
            System.out.println("B");
        } else if (50 <= m+f && m+f < 65) {
            System.out.println("C");
        } else if (30 <= m+f && m+f < 50) {
            if (r != -1 && r >= 50) {
            System.out.println("C");
            } else {
            System.out.println("D");
            }
        } else {
            System.out.println("F");
        }
        }

        System.exit(0);

    } catch (Exception e) {
        System.out.println(e.getMessage());
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    }
    }
}
