import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class SingletonPattern {

    // Volatile variable ensures thread-safety and proper memory visibility
    private static volatile SingletonPattern instance;

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // Private constructor stops unauthorized instantiations
    private SingletonPattern() {
        if (instance != null) {
            throw new IllegalStateException("Instance already exists. Use getInstance() method.");
        }
    }

    // Thread-safe Double-Checked Locking implementation
    public static SingletonPattern getInstance() {
        SingletonPattern result = instance;
        if (result == null) {
            synchronized (SingletonPattern.class) {
                result = instance;
                if (result == null) {
                    instance = result = new SingletonPattern();
                }
            }
        }
        return result;
    }

    // Logging utility method
    public void log(String message) {
        String timestamp = LocalDateTime.now().format(formatter);
        System.out.println("[" + timestamp + "]" + message);
    }

    // Main method correctly nested inside the class scope
    public static void main(String[] args) {
        System.out.println("Testing Singleton Pattern");

        // Fetching the singleton instances
        SingletonPattern logger1 = SingletonPattern.getInstance();
        SingletonPattern logger2 = SingletonPattern.getInstance();

        logger1.log("First message.");
        logger2.log("Second message.");

        // Asserting both references point to the exact same object
        System.out.println("\nVerification Results");
        System.out.println("Are both instances identical? " + (logger1 == logger2));
        System.out.println("Instance 1 HashCode: " + logger1.hashCode());
        System.out.println("Instance 2 HashCode: " + logger2.hashCode());
    }
}