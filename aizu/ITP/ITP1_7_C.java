import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import java.util.stream.Collectors;
import java.util.stream.Stream;

import java.util.Set;
import java.util.HashSet;

public class Main{

    public static void main(String[] args) {
    try {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        List<String> lines = new ArrayList<String>();
        String line = "";

        while((line = br.readLine()) != null){
        lines.add(line);
        }
        br.close();

        //lines.add("4 5");
        //lines.add("1 1 3 4 5");
        //lines.add("2 2 2 4 5");
        //lines.add("3 3 0 1 1");
        //lines.add("2 3 4 4 6");

        Integer row = Integer.parseInt(lines.get(0).split(" ")[1]);
        List<String> newLines = new ArrayList<String>();

        Integer[] rows = Collections.nCopies(row+1, 0).toArray(new Integer[row+1]);

        for (int i = 1; i < lines.size(); i++) {
        String[] columns = lines.get(i).split(" ");
        List<Integer> list = new ArrayList<Integer>();
        for (int j = 0; j < columns.length; j++) {
            Integer c = Integer.parseInt(columns[j]);
            rows[j] = rows[j] + c;
            list.add(c);
        }
        Integer sum = list.stream().mapToInt(x -> x).sum();
        rows[row] = sum + rows[row];
        newLines.add(lines.get(i) + " " + sum);
        }

        for (String e: newLines) {
        System.out.println(e);
        }

        String[] alpha = new String[row+1];
        for (int i = 0; i < row+1; i++) {
        alpha[i] = String.valueOf(rows[i]);
        }
        String s = Arrays.stream(alpha).collect(Collectors.joining(" "));
        System.out.println(s);

        System.exit(0);

    } catch (Exception e) {
        System.out.println(e.getMessage());
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    }
    }
}
