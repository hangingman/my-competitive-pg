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

        for (String line = br.readLine(); line != null; line = br.readLine()) {
        lines.add(line);
        }

        //lines.add("3");
        //lines.add("1 1 3 8");
        //lines.add("3 2 2 7");
        //lines.add("4 3 8 1");

        br.close();

        Integer[][][] doom = new Integer[4][3][10];

        for (int i = 0; i < doom.length; i++) {
        for (int j = 0; j < doom[i].length; j++) {
            for (int k = 0; k < doom[i][j].length; k++) {
            doom[i][j][k] = 0;
            }
        }
        }

        for (int i = 1; i < lines.size(); i++) {
        String[] sep = lines.get(i).split(" ");
        Integer no = Integer.parseInt(sep[0]) - 1;
        Integer floor = Integer.parseInt(sep[1]) - 1;
        Integer room = Integer.parseInt(sep[2]) - 1;

        doom[no][floor][room] += Integer.parseInt(sep[3]);
        }

        for (int i = 0; i < doom.length; i++) {
        for (int j = 0; j < doom[i].length; j++) {
            String t = Arrays.toString(doom[i][j]);
            t = t.replaceAll(",", "");
            t = t.substring(1, t.length() - 1);
            t = " " + t;

            //if (i==doom.length-1 && j==doom[i].length-1) {
            //  System.out.print(t);
            //} else {
            System.out.println(t);
            //}
        }
        if (i!=doom.length-1) {
            System.out.println("####################");
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
