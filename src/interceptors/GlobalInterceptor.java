package interceptors;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.General_Data;
import entities.Users;
import lib.Recaptcha;
import models.CovidModel;
import models.IntegrationsData;
import models.SettingsData;
import models.SocialData;


@Transactional
public class GlobalInterceptor extends HandlerInterceptorAdapter  {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
	
	/**************************************************
	 * @author Hau
	 * 
	 * @return tra ve duong dan cua trang
	 * 
	 * APPURL: http://localhost:8080/LTW_NEWS/
	 * HOMEURL http://localhost:8080/LTW_NEWS/index.htm
	 **************************************************/
	public void setAppUrl(HttpServletRequest request) {
		// set path 
		String APPURL = String.format("%s://%s:%s%s", request.getScheme(), request.getServerName(), request.getServerPort(), request.getContextPath() );
		request.setAttribute("APPURL", APPURL);
		
		String HOMEURL = String.format("%s://%s:%s%s/index.htm", request.getScheme(), request.getServerName(), request.getServerPort(), request.getContextPath() );
		request.setAttribute("HOMEURL", HOMEURL);
		
		String ADMINURL = String.format("%s://%s:%s%s/admin", request.getScheme(), request.getServerName(), request.getServerPort(), request.getContextPath() );
		request.setAttribute("ADMINURL", ADMINURL);
		
	}
	
	
	/**************************************************
	 * @author Hau
	 * 
	 * @return lay du lieu chung
	 **************************************************/
	public SettingsData getGeneralData(String name) {
		ObjectMapper mapper = new ObjectMapper();
		Session session = factory.openSession();
		String hql = String.format("FROM General_Data WHERE name = :name"); 
		Query query = session.createQuery(hql); 
		query.setParameter("name", name); 
		
		SettingsData result = null;
		try {
			General_Data json = (General_Data) query.list().get(0);
			session.close();
			result = mapper.readValue(json.getData(), SettingsData.class);
		}catch(Exception ex) {
			result =  null;
		}
		return result;
	}
	

	/**************************************************
	 * @author Hau
	 * 
	 * @return lay du lieu chung
	 **************************************************/
	public SocialData getSocialData(String name) {
		ObjectMapper mapper = new ObjectMapper();
		Session session = factory.openSession();
		String hql = String.format("FROM General_Data WHERE name = :name"); 
		Query query = session.createQuery(hql); 
		query.setParameter("name", name); 
		
		SocialData result = null;
		try {
			General_Data json = (General_Data) query.list().get(0);
			session.close();
			result = mapper.readValue(json.getData(), SocialData.class);
		}catch(Exception ex) {
			result =  null;
		}
		return result;
	}
	
	public IntegrationsData getIntegrationsData(String name) {
		ObjectMapper mapper = new ObjectMapper();
		Session session = factory.openSession();
		String hql = String.format("FROM General_Data WHERE name = :name"); 
		Query query = session.createQuery(hql); 
		query.setParameter("name", name); 
		
		IntegrationsData result = null;
		try {
			General_Data json = (General_Data) query.list().get(0);
			session.close();
			result = mapper.readValue(json.getData(), IntegrationsData.class);
		}catch(Exception ex) {
			result =  null;
		}
		return result;
	}
	
	
	
	/**************************************************
	 * @author Hau
	 * 
	 * @return lay cac cai dat tong quat 
	 **************************************************/
	public void setGeneralData(HttpServletRequest request) {
		request.setAttribute("SettingsData", getGeneralData("settings"));
		request.setAttribute("SocialData", getSocialData("social"));
		request.setAttribute("Recaptcha", new Recaptcha());
		request.setAttribute("IntegrationsData", getIntegrationsData("integrations")); 
	}
	
	
	
	/**************************************************
	 * @author Hau
	 * 
	 * @return lay nam hien tai
	 **************************************************/
	public void setCurrentYear(HttpServletRequest request) {
		Date date = new Date();  
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		int year = calendar.get(Calendar.YEAR);  
		request.setAttribute("currentYear", year);
	}
	
	
	@SuppressWarnings("unchecked")
	public void setAuthUser(HttpServletRequest request) {
		Principal userPrincipal = (Principal) request.getUserPrincipal();
		Users AuthUser = null;
		if(userPrincipal != null) {
			try 
			{
				Session session = factory.openSession();
				String hql = "SELECT u FROM Users u "
							+ "WHERE u.email = :email";
				
				Query query = session.createQuery(hql);
				query.setParameter("email", userPrincipal.getName());
				
				List<Users> list = query.list();
				AuthUser = list.get(0);
				session.close();
			}
			catch(Exception ex) 
			{
				AuthUser = null;
			}
			
		}
		request.setAttribute("AuthUser", AuthUser);
	}
	

	/**
	 * Hàm để khai báo một biến Date Format chung cho toàn bộ web
	 * @param request
	 */
	public void setDateFormat(HttpServletRequest request) {
		DateFormat dateFormat = new SimpleDateFormat("dd MMMM, yyyy", new Locale("vi", "VN"));
		request.setAttribute("dateFormat", dateFormat);
	}
	
	
	//GET DATA COVID-19
	
	
	
		public void dataCovid19(HttpServletRequest request, boolean covidworld) {
			try{
				
		        String url = "https://disease.sh/v3/covid-19/countries";
		        if(covidworld)
		        url = "https://disease.sh/v3/covid-19/all";
		        URL obj = new URL(url);
		        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		        con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36");
		        
		            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		            String inputLine;
		            StringBuffer response = new StringBuffer();
		            while((inputLine = in.readLine())!=null){
		                response.append(inputLine);
		            }
		            in.close();
		            con.disconnect();
//		             CONVERT JSON TO model[]
		            String json = response.toString();
		            if(json.contains("long")){
		            	 json.replace("long", "Long");
		            	 CovidModel[] result = mapper.readValue(json, CovidModel[].class);
		            	 //System.out.println(result[3].country);
		            	 request.setAttribute("covidlist",result);
		 	             dataCovid19(request,true); // Gọi lại hàm để lấy dữ liệu covid all
		            }
		            else{
				         String[] covidWorld = new String[4];
				         covidWorld[0] = mapper.readTree(json).path("cases").asText();
				         //System.out.println("cases: "+covidWorld[0]);
				         covidWorld[1] = mapper.readTree(json).path("todayCases").asText();
				         covidWorld[2] = mapper.readTree(json).path("deaths").asText();
				         covidWorld[3] = mapper.readTree(json).path("todayDeaths").asText();
				         request.setAttribute("covidworld",covidWorld);
		            }     
		    }
		    
		        catch(Exception e){
		            System.out.println(e);  
		        }
			
		}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler) throws Exception{
		setAppUrl(request);
		setGeneralData(request);
		setCurrentYear(request);
		setDateFormat(request);	
		setAuthUser(request);
		
		dataCovid19(request,false);
		return true;
	}
}
