package org.example;

public class MyServices {
    private final ExternalAPI externalApi;

    // Constructor injection - crucial for letting Mockito inject the dummy bot later
    public MyServices(ExternalAPI externalApi) {
        this.externalApi = externalApi;
    }

    public String fetchData() {
        return externalApi.getData();
    }
}