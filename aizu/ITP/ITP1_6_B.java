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

        // lines.add("47");
        // lines.add("S 10");
        // lines.add("S 11");
        // lines.add("S 12");
        // lines.add("S 13");
        // lines.add("H 1");

        br.close();

        List<Integer> S = new ArrayList<>(Arrays.asList(1,2,3,4,5,6,7,8,9,10,11,12,13));
        List<Integer> H = new ArrayList<>(Arrays.asList(1,2,3,4,5,6,7,8,9,10,11,12,13));
        List<Integer> C = new ArrayList<>(Arrays.asList(1,2,3,4,5,6,7,8,9,10,11,12,13));
        List<Integer> D = new ArrayList<>(Arrays.asList(1,2,3,4,5,6,7,8,9,10,11,12,13));

        for (int i = 1; i < lines.size(); i++) {
        String type = lines.get(i).split(" ")[0];
        Integer num = Integer.parseInt(lines.get(i).split(" ")[1]);
        if (type.equals("S")) {
            S.remove(num);
        } else if (type.equals("H")) {
            H.remove(num);
        } else if (type.equals("C")) {
            C.remove(num);
        } else if (type.equals("D")) {
            D.remove(num);
        }
        }

        for (Integer s : S) { System.out.println("S " + s); }
        for (Integer s : H) { System.out.println("H " + s); }
        for (Integer s : C) { System.out.println("C " + s); }
        for (Integer s : D) { System.out.println("D " + s); }

        System.exit(0);

    } catch (Exception e) {
        System.out.println(e.getMessage());
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    }
    }
}
