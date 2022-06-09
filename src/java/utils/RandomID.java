/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class RandomID {
  
    // function to generate a random string of length n
    public String getARandomID()
    {
        // chose a Character random from this String
        String AlphaNumericString ="0123456789"
                                    + "abcdefghijklmnopqrstuvxyz";
        // create StringBuffer size of AlphaNumericString
        StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 10; i++) {  
            // generate a random number between
            // 0 to AlphaNumericString variable length
            int index
                = (int)(AlphaNumericString.length()
                        * Math.random());  
            // add Character one by one in end of sb
            sb.append(AlphaNumericString
                          .charAt(index));
        }
        return sb.toString();
    }

    
}