import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;

public class Main{
    public static void main(String[] args) {
    try {
        BufferedReader stdReader = new BufferedReader(new InputStreamReader(System.in));
        String line;
        while ((line = stdReader.readLine()) != null) {
        String[] splits = line.split(" ");

        Long a = Long.parseLong(splits[0]);
        Long b = Long.parseLong(splits[1]);

        Long d = a / b;
        Long r = a % b;

        Double f = Double.parseDouble(splits[0]) / Double.parseDouble(splits[1]);
        System.out.println( String.format("%d %d %.5f", d, r, f));
        }
        stdReader.close();
    } catch (Exception e) {
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    }
    }
}
