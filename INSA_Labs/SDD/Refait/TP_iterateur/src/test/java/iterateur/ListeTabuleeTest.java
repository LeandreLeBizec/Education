package iterateur;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class ListeTabuleeTest {

    ListeTabulee l;

    @BeforeEach
    void SetUp(){
        l = new ListeTabulee();
    }

    @Test
    void estVideTest(){
        assertTrue(l.estVide());
    }
}
