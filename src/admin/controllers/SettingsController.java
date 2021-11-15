package admin.controllers;


import java.awt.Image;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.imageio.ImageIO;
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
import models.SettingsData;
import models.SocialData;

@Transactional
@Controller
@RequestMapping("/admin/settings/")
public class SettingsController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ObjectMapper mapper;
	

	public SettingsData getGeneralData(String name) {
		Session session = factory.getCurrentSession();
		String hql = String.format("FROM General_Data WHERE name = :name"); 
		Query query = session.createQuery(hql); 
		query.setParameter("name", name); 
		try {
			General_Data json = (General_Data) query.list().get(0);
			return mapper.readValue(json.getData(), SettingsData.class);
		}catch(Exception ex) {
			return null;
		}
	}
	
	public SocialData getSocialData(String name) {
		Session session = factory.getCurrentSession();
		String hql = String.format("FROM General_Data WHERE name = :name"); 
		Query query = session.createQuery(hql); 
		query.setParameter("name", name); 
		try {
			General_Data json = (General_Data) query.list().get(0);
			return mapper.readValue(json.getData(), SocialData.class);
		}catch(Exception ex) {
			return null;
		}
	}
	
	@RequestMapping(value="site",method = RequestMethod.GET)
	public String SiteController(ModelMap model, HttpServletRequest request)
	{
		
		SettingsData settings = getGeneralData("settings");
		model.addAttribute("settings", settings);
		return "admin/settings-site";
	}
	
	
	@RequestMapping(value="site",method = RequestMethod.POST)
	public String SiteSubmit(HttpServletRequest request,ModelMap model,@RequestParam("site_name") String site_name,@RequestParam("site_slogan") String site_slogan ,
											@RequestParam("site_description") String site_description,@RequestParam("site_keywords") String site_keywords)
	{

		SettingsData settings = getGeneralData("settings");
		if(site_name.isEmpty()||site_description.isEmpty()||site_keywords.isEmpty()||site_slogan.isEmpty()) {
			request.getSession().setAttribute("error","Vui lòng không để trống");
			return "redirect:/admin/settings/site.htm";
		}
		if(settings.getSite_name().equalsIgnoreCase(site_name) && settings.getSite_slogan().equalsIgnoreCase(site_slogan) && settings.getSite_description().equalsIgnoreCase(site_description) && settings.getSite_keywords().equalsIgnoreCase(site_keywords))
		{
			request.getSession().setAttribute("change","Không có dữ liệu được thay đổi");
			return "redirect:/admin/settings/site.htm";
		}
		
		settings.setSite_name(site_name);
		settings.setSite_slogan(site_slogan);
		settings.setSite_description(site_description);
		settings.setSite_keywords(site_keywords);
		try {
			String data = mapper.writeValueAsString(settings);
			System.out.println("DATA: "+data);
			Session session = factory.getCurrentSession();
			String hql = "UPDATE General_Data gd SET gd.data = :data where gd.name = 'settings'";
			Query query = session.createQuery(hql); 
			query.setParameter("data", data);
			query.executeUpdate();
			request.getSession().setAttribute("success","Lưu thành công");
			return "redirect:/admin/settings/site.htm";
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (Exception e)
		{
			System.out.println(e);
			request.getSession().setAttribute("error","Lưu không thành công");
		}
		
		return "redirect:/admin/settings/site.htm";
	}
	
	// SETTING SOCIAL
	@RequestMapping(value="social",method = RequestMethod.GET)
	public String SocialController(ModelMap model)
	{
		SocialData social = getSocialData("social");
		System.out.println("facebook: "+social.getFacebook());
		model.addAttribute("social", social);
		return "admin/settings-social";
	}
	
	@RequestMapping(value="social",method = RequestMethod.POST)
	public String SocialSubmit(HttpServletRequest request,ModelMap model,@RequestParam("facebook") String facebook, @RequestParam("twitter") String twitter ,
											@RequestParam("instagram") String instagram, @RequestParam("pinterest") String pinterest,
											@RequestParam("tumblr") String tumblr, @RequestParam("telegram") String telegram, @RequestParam("whatsapp") String whatsapp)
	{
		
		SocialData social = getSocialData("social");
		if(facebook.isEmpty()||twitter.isEmpty()||instagram.isEmpty()||pinterest.isEmpty() || tumblr.isEmpty()||telegram.isEmpty()||whatsapp.isEmpty())
		{
			request.getSession().setAttribute("error","Vui lòng không để trống");
			return "redirect:/admin/settings/social.htm";
		}
		if(social.getFacebook().equalsIgnoreCase(facebook) && social.getTwitter().equalsIgnoreCase(twitter) && social.getInstagram().equalsIgnoreCase(instagram) && social.getPinterest().equalsIgnoreCase(pinterest) && social.getTumblr().equalsIgnoreCase(tumblr) && social.getTelegram().equalsIgnoreCase(telegram) && social.getWhatsapp().equalsIgnoreCase(whatsapp))
		{
			request.getSession().setAttribute("change","Không có dữ liệu được thay đổi");
			return "redirect:/admin/settings/social.htm";
		}
		
		social.setFacebook(facebook);
		social.setTwitter(twitter);
		social.setInstagram(instagram);
		social.setPinterest(pinterest);
		social.setTumblr(tumblr);
		social.setTelegram(telegram);
		social.setWhatsapp(whatsapp);
		try {
			String data = mapper.writeValueAsString(social);
			Session session = factory.getCurrentSession();
			String hql = "UPDATE General_Data gd SET gd.data = :data where gd.name = 'social'";
			Query query = session.createQuery(hql); 
			query.setParameter("data", data);
			query.executeUpdate();
			request.getSession().setAttribute("success","Lưu thành công");
			return "redirect:/admin/settings/social.htm";
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (Exception e)
		{
			System.out.println(e);
			request.getSession().setAttribute("error","Lưu không thành công");
		}
		return "redirect:/admin/settings/social.htm";
	}
	
	// SETTINGS LOGO
	@RequestMapping(value="logo",method = RequestMethod.GET)
	public String LogoController(ModelMap model)
	{
		SettingsData settings = getGeneralData("settings");
		model.addAttribute("settings", settings);
		return "admin/settings-logo";
	}
	
	@RequestMapping(value="logo",method = RequestMethod.POST)
	public String SaveLogo(HttpServletRequest request,ModelMap model,@RequestParam("logotype") String logotype, @RequestParam("logomark") String logomark)
	{
		
			if(logotype==null||logotype.isEmpty())
			{
				request.getSession().setAttribute("logoerror", "Vui lòng không để trống");
				return "redirect:/admin/settings/logo.htm";
			}
			if(logomark==null||logomark.isEmpty())
			{
				request.getSession().setAttribute("logomarkerror", "Vui lòng không để trống");
				return "redirect:/admin/settings/logo.htm";
			}

			SettingsData settings = getGeneralData("settings");
			settings.setLogotype(logotype);
			settings.setLogomark(logomark);
			try {
				String data = mapper.writeValueAsString(settings);
				System.out.println("DATA: "+data);
				Session session = factory.getCurrentSession();
				String hql = "UPDATE General_Data gd SET gd.data = :data where gd.name = 'settings'";
				Query query = session.createQuery(hql); 
				query.setParameter("data", data);
				query.executeUpdate();
				request.getSession().setAttribute("success","Lưu thành công");
				return "redirect:/admin/settings/logo.htm";
				} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}catch (Exception e)
				{
					System.out.println(e);
					request.getSession().setAttribute("error","Lưu không thành công");
					
				}
			return "redirect:/admin/settings/logo.htm";
	}
	
	public boolean checkImage(String url) // xai khong duoc
	{
		Image image;
		try {
			image = ImageIO.read(new URL(url));
			if(image != null){
		    System.out.println("IMAGE"); 
		    return true;
		}else{
		    System.out.println("NOT IMAGE"); 
		    return false;
		}
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
}
