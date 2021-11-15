package admin.controllers;



import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import entities.General_Data;
import models.IntegrationsData;


@Transactional
@Controller
@RequestMapping("/admin/integrations/")
public class IntegrationsController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ObjectMapper mapper;
	
	public IntegrationsData getIntegrationData() {
		Session session = factory.getCurrentSession();
		String hql = String.format("FROM General_Data WHERE name = :name"); 
		Query query = session.createQuery(hql); 
		query.setParameter("name", "integrations"); 
		try {
			General_Data json = (General_Data) query.list().get(0);
			return mapper.readValue(json.getData(), IntegrationsData.class);
		}catch(Exception ex) {
			return null;
		}
	}

	
	@RequestMapping(value="recaptcha",method = RequestMethod.GET)
	public String ReCaptchaController(ModelMap model)
	{
		IntegrationsData integration = getIntegrationData();
		model.addAttribute("integration", integration);
		return "admin/re-captcha";
	}
	
	@RequestMapping(value="recaptcha",method = RequestMethod.POST)
	public String SetRecaptcha(HttpServletRequest request,ModelMap model,
			@RequestParam(value = "comment-recaptcha", required = false) String comment
			)
		{
		
		IntegrationsData integration = getIntegrationData();
		integration.setComment_recaptcha(Boolean.parseBoolean(comment));
		try {
			String data = mapper.writeValueAsString(integration);
			
			Session session = factory.getCurrentSession();
			String hql = "UPDATE General_Data gd SET gd.data = :data where gd.name = 'integrations'";
			Query query = session.createQuery(hql); 
			query.setParameter("data", data);
			query.executeUpdate();
			request.getSession().setAttribute("success","Lưu thành công");
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (Exception e){
				System.out.println(e);
				request.getSession().setAttribute("error","Lưu không thành công");
				
			}
		return "redirect:/admin/integrations/recaptcha.htm";
	}
	
	@RequestMapping(value="google-analytics",method = RequestMethod.GET)
	public String GGAnalyticsController(ModelMap model)
	{
		IntegrationsData integrations = getIntegrationData();
		model.addAttribute("integrations", integrations);
		return "admin/google-analytics";
	}
	
	@RequestMapping(value="google-analytics",method = RequestMethod.POST)
	public String GGAnalyticsSet( HttpServletRequest request,ModelMap model,
			@RequestParam("property_id") String protertyid)
	{
		IntegrationsData integration = getIntegrationData();
		if(protertyid == null) {
			integration.setProperty_id("");
		}else {
			integration.setProperty_id(protertyid);
		}
		
		
		try {
			String data = mapper.writeValueAsString(integration);
			
			Session session = factory.getCurrentSession();
			String hql = "UPDATE General_Data gd SET gd.data = :data where gd.name = 'integrations'";
			Query query = session.createQuery(hql); 
			query.setParameter("data", data);
			query.executeUpdate();
			request.getSession().setAttribute("success","Lưu thành công");
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (Exception e){
				System.out.println(e);
				request.getSession().setAttribute("error","Lưu không thành công");
			}
		return "redirect:/admin/integrations/google-analytics.htm";
	}
	
}
