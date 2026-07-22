import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class AAAPatternTest {

    private int playerHealth;
    private int playerCredits;

    @Before
    public void setup() {
        System.out.println("Setup Method");
        playerHealth = 150;
        playerCredits = 3900;
    }

    @After
    public void teardown() {
        System.out.println("Teardown Method");
        playerHealth = 0;
        playerCredits = 0;
    }

    @Test
    public void testTakingDamage() {
        int incomingVandalBodyShot = 40;
        int expectedHealthAfterHit = 110;

        playerHealth = playerHealth - incomingVandalBodyShot;

        assertEquals(expectedHealthAfterHit, playerHealth);
    }

    @Test
    public void testBuyingWeapon() {

        int phantomCost = 2900;
        int expectedCredits = 1000;

        playerCredits = playerCredits - phantomCost;

        assertEquals(expectedCredits, playerCredits);
    }
}