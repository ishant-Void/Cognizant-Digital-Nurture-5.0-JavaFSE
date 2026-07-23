package org.example;

import static org.mockito.Mockito.*;

import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.*;
import org.mockito.*;
import org.mockito.junit.jupiter.*;

@ExtendWith(MockitoExtension.class)
public class MyServiceTest {

    @Mock
    private ExternalApi mockApi;

    @InjectMocks
    private MyServices myService;

    @Test
    public void testVerifyInteraction() {
        myService.fetchData();

        verify(mockApi, times(1)).getData();
    }
}