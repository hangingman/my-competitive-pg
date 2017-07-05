import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Main{
    public static void main(String[] args) throws IOException {

    BufferedReader br = null;

    try {
        br = new BufferedReader(new InputStreamReader(System.in));
        List<String> lines = new ArrayList<String>();

        for (String line = br.readLine(); line != null; line = br.readLine()) {
        lines.add(line);
        }

        /**

        lines.add("aaaaaaaaaa");
        lines.add("bb bb bb aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa");
        lines.add("aaa aaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa");
        lines.add("aaaaaaaaaa xxx xxxxxxxxx aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa");
        lines.add("aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa b b b b b b b aaaaaaaaaa aaaaaaaaaa");
        lines.add("aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaaa a a a a");
        lines.add("aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa");
        lines.add("aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa a a a a");
        lines.add("aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa x");
        lines.add("aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa x x x x");
        lines.add("aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa x x xaaaaaaaaaa");
        lines.add("END_OF_TEXT"); */

        String keyword = lines.get(0).toLowerCase();
        Integer count = 0;

        for (int i = 1; i < lines.size() - 1; i++) {
        for (String e : lines.get(i).split(" ")) {
            String word = e.toLowerCase();
            if (word.equals(keyword)) {
            count++;
            }
        }
        }

        System.out.println(count);
        System.exit(0);

    } catch (Exception e) {
        System.out.println(e.getMessage());
        System.out.println(Arrays.toString(e.getStackTrace()));
        System.exit(0);
    } finally {
        br.close();
    }
    }
}
