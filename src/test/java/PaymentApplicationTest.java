import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class PaymentApplicationTest {

    @Test
    void paymentShouldBeProcessedSuccessfully() {
        assertEquals(
            "Payment processed successfully",
            PaymentApplication.processPayment()
        );
    }
}