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
        Double r = Double.parseDouble(line);
        System.out.println( String.format("%f %f", PI*r*r, 2*PI*r) );
        }
        stdReader.close();
    } catch (Exception e) {
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    }
    }
}
