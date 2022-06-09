/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.LinkedHashMap;

/**
 *
 * @author tvfep
 */
public class ProductError {
    LinkedHashMap<String, String> productError;

    public ProductError() {
    }

    public ProductError(LinkedHashMap<String, String> productError) {
        this.productError = productError;
    }

    public LinkedHashMap<String, String> getProductError() {
        return productError;
    }

    public void setProductError(LinkedHashMap<String, String> productError) {
        this.productError = productError;
    }    

    
    
    @Override
    public String toString() {
        return "ProductError{" + "productError=" + productError + '}';
    }        
    
}
