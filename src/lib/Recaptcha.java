package lib;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

import helpers.CommonHelper;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Filter for capturing Captcha fields.
 * It's purpose is to store these values internally
 */
public class Recaptcha {
 
 private String url = "https://www.google.com/recaptcha/api/siteverify";
 public final String site_key = "6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI";
 public final String secret_key = "6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe";
 
 public boolean verification(String recaptcha_response) throws MalformedURLException, IOException {
	 
	try {
		String response = "";
	  	HttpsURLConnection conn = (HttpsURLConnection) new URL(url).openConnection();
	  	conn.setRequestMethod("POST");
		conn.setDoInput(true);
	    conn.setDoOutput(true);
			  
	    HashMap<String, String> postDataParams = new HashMap<String, String>();
	    postDataParams.put("secret", secret_key);
	    postDataParams.put("response", recaptcha_response);
	    OutputStream os = conn.getOutputStream();
	    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"));
	    writer.write(CommonHelper.getPostDataString(postDataParams));
	    writer.flush();
	    writer.close();
	    os.close();

	    int responseCode=conn.getResponseCode();

	    if (responseCode == HttpsURLConnection.HTTP_OK) {
	        String line;
	        BufferedReader br=new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        while ((line=br.readLine()) != null) {
	            response+=line;
	        }
	    }
	    else {
	        response="";
	    }
	    ObjectMapper objectMapper = new ObjectMapper();
	    JsonNode jsonNode = objectMapper.readTree(response);
	    if(jsonNode.get("success").asBoolean() != true) {
	    	return false;
	    }
	}catch(Exception ex) {
		return false;
	}
	
    return true;
 }

	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getSiteKey() {
		return site_key;
	}
	
	public String getSecretKey() {
		return secret_key;
	}
	 
 
}
