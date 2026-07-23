package org.example;

public class MyServices {
    private final ExternalApi externalApi;

    public MyServices(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }

    public String fetchData() {
        return externalApi.getData();
    }
}