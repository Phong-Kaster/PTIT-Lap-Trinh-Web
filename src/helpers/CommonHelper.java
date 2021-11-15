package helpers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.text.NumberFormat;

public class CommonHelper{
	public static String RandomString(int length) {
	    byte[] array = new byte[length]; // length is bounded by 7
	    new Random().nextBytes(array);
	    String generatedString = new String(array, Charset.forName("UTF-8"));
	    return generatedString;
	}
	
	/**
	 * Kiểm tra một giá trị có nằm trong list giá trị khác hay ko
	 * @param <T>
	 * @param array
	 * @param v
	 * @return
	 */
	public static <T> boolean contains(final T[] array, final T v) {
	    if (v == null) {
	        for (final T e : array)
	            if (e == null)
	                return true;
	    } 
	    else {
	        for (final T e : array)
	            if (e == v || v.equals(e))
	                return true;
	    }

	    return false;
	}
	
	  public static String getPostDataString(HashMap<String, String> params) throws UnsupportedEncodingException{
	        StringBuilder result = new StringBuilder();
	        boolean first = true;
	        for(Map.Entry<String, String> entry : params.entrySet()){
	        	if(entry == null)  continue;

	            if (first)
	                first = false;
	            else
	                result.append("&");
	            
	            
	            result.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
	            result.append("=");
	            result.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
	        }

	        return result.toString();
	    }
	  	  
	  public static String formatNumber(int input)
	  {
		  NumberFormat myFormat = NumberFormat.getInstance();
		  return myFormat.format(input);
	  }
	  
	  public static String formatBigNumber(double n, int iteration)
	  {
		  char[] c = new char[]{'K', 'M', 'B', 'T'};

		  /**
		   * Recursive implementation, invokes itself for each factor of a thousand, increasing the class on each invokation.
		   * @param n the number to format
		   * @param iteration in fact this is the class from the array c
		   * @return a String representing the number n formatted in a cool looking way.
		   */
		      double d = ((long) n / 100) / 10.0;
		      boolean isRound = (d * 10) %10 == 0;//true if the decimal part is equal to 0 (then it's trimmed anyway)
		      return (d < 1000? //this determines the class, i.e. 'k', 'm' etc
		          ((d > 99.9 || isRound || (!isRound && d > 9.99)? //this decides whether to trim the decimals
		           (int) d * 10 / 10 : d + "" // (int) d * 10 / 10 drops the decimal
		           ) + "" + c[iteration]) 
		          : formatBigNumber(d, iteration+1));

	  }
	  

	  public static Date ConverToDate(LocalDate localDate) {
		  return Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
	  }
}
	  


