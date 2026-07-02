package Week1.DSA;

import java.util.Arrays;
import java.util.Comparator;

class Product {
    int productId;
    String productName;
    String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    @Override
    public String toString() {
        return "Product ID: " + productId + ", Name: " + productName + ", Category: " + category;
    }
}

public class EcommerceSearch {

    public static Product linearSearch(Product[] products, int targetId) {
        for (Product product : products) {
            if (product.productId == targetId) {
                return product;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, int targetId) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (products[mid].productId == targetId) {
                return products[mid];
            }

            if (products[mid].productId < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] inventory = {
                new Product(105, "Wireless Mouse", "Electronics"),
                new Product(101, "Mechanical Keyboard", "Electronics"),
                new Product(108, "Gaming Monitor", "Electronics"),
                new Product(102, "Desk Mat", "Accessories"),
                new Product(104, "USB-C Cable", "Accessories")
        };

        int target = 108;

        System.out.println("Linear Search Result:");
        Product res1 = linearSearch(inventory, target);
        System.out.println(res1);

        Arrays.sort(inventory, Comparator.comparingInt(p -> p.productId));

        System.out.println();
        System.out.println("Binary Search Result:");
        Product res2 = binarySearch(inventory, target);
        System.out.println(res2);
    }
}