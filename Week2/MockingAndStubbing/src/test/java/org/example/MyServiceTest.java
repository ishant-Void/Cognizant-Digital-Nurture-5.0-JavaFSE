package org.example;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class MyServiceTest {

    @Mock
    private ExternalAPI mockApi;

    @InjectMocks
    private MyServices myService;

    @Test
    public void testExternalApi() {
        when(mockApi.getData()).thenReturn("Mock Data");

        String result = myService.fetchData();

        assertEquals("Mock Data", result);
    }
}