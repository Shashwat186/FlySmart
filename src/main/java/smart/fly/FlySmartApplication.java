package smart.fly;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
 
@SpringBootApplication
@ComponentScan(basePackages = {"smart.fly"})
public class FlySmartApplication {
    public static void main(String[] args) {
SpringApplication.run(FlySmartApplication.class, args);
    }
}