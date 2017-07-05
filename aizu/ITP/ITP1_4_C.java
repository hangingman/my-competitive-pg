import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;

import static java.lang.Math.PI;

public class Main{
    public static void main(String[] args) {
    try {
        BufferedReader stdReader = new BufferedReader(new InputStreamReader(System.in));
        String line;
        while ((line = stdReader.readLine()) != null) {
        String[] splits = line.split(" ");
        Integer a = Integer.parseInt(splits[0]);
        Integer b = Integer.parseInt(splits[2]);
        String op = splits[1];
        if (op.equals("?")) {
            System.exit(0);
        } else {
            if (op.equals("+")) {
            System.out.println( String.format("%d", a + b) );
            } else if (op.equals("-")) {
            System.out.println( String.format("%d", a - b) );
            } else if (op.equals("*")) {
            System.out.println( String.format("%d", a * b) );
            } else if (op.equals("/")) {
            System.out.println( String.format("%d", a / b) );
            }
        }
        }
        stdReader.close();
    } catch (Exception e) {
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    }
    }
}
