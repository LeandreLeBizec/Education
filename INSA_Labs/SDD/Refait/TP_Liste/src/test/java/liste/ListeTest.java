package liste;

import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;

public class ListeTest {

    ListeDoubleChainage<Integer> l;
    int i;

    @BeforeEach
    void SetUp(){
        l = new ListeDoubleChainage<>();
        i = 2;
    }


    @Test
    public void estVideTest() throws EstVideException, EstSortieException {
        l.ajouterD(i);

    }


    @Test
    public void shouldAnswerWithTrue()
    {
        assertTrue( true );
    }
}
