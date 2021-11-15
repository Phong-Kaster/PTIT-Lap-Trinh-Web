package admin.controllers;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import entities.Categories;
import entities.Widgets;
import helpers.CommonHelper;
import models.CategoriesModel;


@Transactional
@Controller
@RequestMapping("/admin")
public class WidgetController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
		
	
	/**
	 * Lấy thông tin widget theo id
	 * @param cat_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Widgets getWidget(String widget_id)
	{
		Widgets widget = null;
		try 
		{
			Session session = factory.openSession();
			String hql = "FROM Widgets w WHERE w.id = :widget_id";
			
			Query query = session.createQuery(hql);
			query.setParameter("widget_id", Integer.parseInt(widget_id));
			List<Widgets> list = query.list();
			widget = list.get(0);
			session.close();
		}
		catch(Exception ex) 
		{
			ex.printStackTrace();
			widget  = null;
		}
		return widget;
	}
	
	/**
	 * Lấy thông tin thể loại theo level
	 * @param parent
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Categories> getCat(int parent){
		Session session = factory.getCurrentSession();
		String hql = "FROM Categories c WHERE parent = :parent"; 
		Query query = session.createQuery(hql); 
		query.setParameter("parent", parent);
		List<Categories> list = query.list();
		return list;
	}
	
	/**
	 * Lấy thông tin thể loại theo id
	 * @param cat_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Categories getCategory(String cat_id)
	{
		try 
		{
			Session session = factory.getCurrentSession();
			String hql = "FROM Categories c "
						+ "WHERE c.id = :cat_id";
			
			Query query = session.createQuery(hql);
			query.setParameter("cat_id", Integer.parseInt(cat_id));
			List<Categories> list = query.list();
			return list.get(0);
		}
		catch(Exception ex) 
		{
			return null;
		}
	}
	
	/**
	 * lấy danh sách widget thứ tự order_widget
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	private List<Widgets> getListWidget(){
		List<Widgets> list = null;
		try 
		{
			Session session = factory.openSession();
			String hql = "SELECT w FROM Widgets w ORDER BY w.order_widget ASC";
			Query query = session.createQuery(hql);
			list = query.list();
			session.close();
		}
		catch(Exception ex) 
		{
			list = null;
		}
		return list;
	}
	
	
	private List<CategoriesModel> getListCategories(){
		List<Categories> listParent = getCat(0);
		List<CategoriesModel> list = new ArrayList<CategoriesModel>();
		for(Categories item: listParent) {
			CategoriesModel cat = new CategoriesModel();
			cat.setCategory(item);
			List<Categories> listChildren = getCat( item.getId());
			if(listChildren != null && listChildren.size() > 0) {
				cat.setChildren(listChildren);
			}
			list.add(cat);
		}
		return list;
	}
	
	@RequestMapping( value="widget", method = RequestMethod.GET)
	public String index(ModelMap model){
		model.addAttribute("listCategories", getListCategories());
		model.addAttribute("listWidget", getListWidget());
		return "admin/widget";
	}
	
	@RequestMapping( value="widget", method = RequestMethod.POST)
	public ResponseEntity<JsonNode> save(ModelMap model, @RequestParam Map<String, Object> params){	
		ObjectNode objectNode = mapper.createObjectNode();
		
		Categories category = null;
		String title = (String) params.get("title");
		String layout = (String) params.get("layout");
		String cat_id = (String) params.get("cat_id");
		int order_widget = Integer.parseInt((String) params.get("order_widget"));
		int num_post = Integer.parseInt((String) params.get("num_post"));
		
		if(title == null || title.trim().length() == 0) {
			objectNode.put("result", 0);
			objectNode.put("msg","Tiêu đề không được bỏ trống!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		if(layout == null || layout.trim().length() == 0) {
			objectNode.put("result", 0);
			objectNode.put("msg","Layout không được bỏ trống!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}else if(!CommonHelper.contains(new String[] { "layout-group-1", "layout-group-2", "layout-group-3", "layout-group-4", "layout-grid-1", "layout-grid-2", "layout-vertical" }, layout)) {
			objectNode.put("result", 0);
			objectNode.put("msg","Layout không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		if(cat_id == null || cat_id.trim().length() == 0) {
			objectNode.put("result", 0);
			objectNode.put("msg","Thể loại không được bỏ trống!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}else {
			category = getCategory(cat_id);
			if(category == null) {
				objectNode.put("result", 0);
				objectNode.put("msg", "Thể loại không hợp lệ!");				
				return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
			}
		}
		
		Widgets widget = new Widgets();
		widget.setTitle(title);
		widget.setLayout(layout);
		widget.setNum_post(num_post);
		widget.setCategory(category);
		widget.setOrder_widget(order_widget);
		
		List<CategoriesModel> listCategories = getListCategories();
		
		Session session = factory.openSession();
		Transaction t =  session.beginTransaction();
		try{   
			session.save(widget);
			t.commit();
			String catHtm = "";
			for(CategoriesModel c: listCategories) {
				catHtm += "<option value='"+c.getCategory().getId()+"' "+(category.getId() ==  c.getCategory().getId() ? "selected" : "")+">"+c.getCategory().getName()+"</option>";
				if(c.getChildren()!= null && c.getChildren().size() > 0) {
					for(Categories child: c.getChildren()) {
						catHtm += "<option value='"+child.getId()+"' "+(category.getId() ==  child.getId() ? "selected" : "")+">&nbsp;&nbsp;&nbsp;--"+child.getName()+"</option>";
					}
				}
			}
		
			String html = "<input type='hidden' name='id[]' value='"+widget.getId()+"'><div class='block block-rounded block-themed block-mode-hidden mb-2' id='widget_"+widget.getId()+"'>" + 
					  "<div class='block-header bg-muted'>" + 
					  "<h3 class='block-title'>"+widget.getTitle()+"</h3>" + 
					  "<div class='block-options'>" + 
					  "<button type='button' class='btn btn-sm btn-alt-secondary' data-toggle='block-option' data-action='content_toggle'><i class='si si-arrow-down'></i></button>" +
					  "\t"+
					  "<button type='button' class='btn btn-sm btn-alt-danger remove-widget'>" + 
					  "<i class='si si-close'></i>" + 
					  "</button>" + 
					  "</div></div>" + 
					  "<div class='block-content'>" + 
					  "<div class='mb-4'>" + 
					  "<label for='title' class='form-label'>Tiêu Đề</label>" + 
					  "<input type='text' class='form-control' name='title[]' placeholder='Tiêu Đề' value='"+widget.getTitle()+"'>" + 
					  "</div>" + 
					  "<div class='mb-4'>" + 
					  "<label for='num_post' class='form-label'>Số lượng bài hiện thị</label>" + 
					  "<input type='number' class='form-control' name='num_post[]' value='"+widget.getNum_post()+"' placeholder='Số lượng bài hiện thị'>" + 
					  "</div>" + 
					  "<div class='mb-4'>" + 
					  "<label for='layout' class='form-label'>Layout</label>" + 
					  "<select class='form-select' id='layout' name='layout[]'>" + 
					  "<option value='layout-group-1' "+(layout.equals("layout-group-1") ? "selected" : "")+">Layout Group 1</option>" + 
					  "<option value='layout-group-2' "+(layout.equals("layout-group-2") ? "selected" : "")+">Layout Group 2</option>" + 
					  "<option value='layout-group-3' "+(layout.equals("layout-group-3") ? "selected" : "")+">Layout Group 3</option>" + 
					  "<option value='layout-group-4' "+(layout.equals("layout-group-4") ? "selected" : "")+">Layout Group 4</option>" + 
					  "<option value='layout-grid-1' "+(layout.equals("layout-group-1") ? "selected" : "")+">Layout Grid 1</option>" + 
					  "<option value='layout-grid-2' "+(layout.equals("layout-grid-2") ? "selected" : "")+">Layout Grid 2</option>" + 
					  "<option value='layout-vertical' "+(layout.equals("layout-vertical") ? "selected" : "")+">Layout Vertical</option>" + 
					  "</select>" + 
					  "</div>" + 
					  "<div class='mb-4'>" + 
					  "<label for='cat_id' class='form-label'>Chuyên Mục</label>" + 
					  "<select class='form-control' id='cat_id' name='cat_id[]'>" +
					  catHtm+
					  "</select>" + 
					  "</div></div></div>";
			objectNode.put("html", html);
			objectNode.put("result", 1);
			objectNode.put("msg", "Thêm thành công!");
		}
		catch(Exception e){
			e.printStackTrace();
			t.rollback();
			objectNode.put("result", 0);
			objectNode.put("msg", "Thêm thất bại!");
		}
		finally{
			session.close();
		}
		return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
	}
	
	@RequestMapping( value="widget", method = RequestMethod.PUT)
	public ResponseEntity<JsonNode> remove(ModelMap model, HttpServletRequest request){	
		ObjectNode objectNode = mapper.createObjectNode();
		Session session = factory.openSession();
		Transaction t =  session.beginTransaction();
		
		String widget_id = request.getParameter("id");
		Widgets widget = getWidget(widget_id);
		if(widget == null) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Widget không tồn tại");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		try{   
			session.delete(widget);
			t.commit();
			objectNode.put("result", 1);
			objectNode.put("msg", "Xóa thành công!");
		}
		catch(Exception e){
			e.printStackTrace();
			t.rollback();
			objectNode.put("result", 0);
			objectNode.put("msg", "Xóa thất bại!");
		}
		finally{
			session.close();
		}
		return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
	}
	
	
	@RequestMapping( value="widget-update", method = RequestMethod.POST)
	public ResponseEntity<JsonNode> update(
			ModelMap model, 
			HttpServletRequest request,
			@RequestParam("id[]") List<Integer> ids,
			@RequestParam("num_post[]") List<Integer> num_posts,
			@RequestParam("title[]") List<String> titles,
			@RequestParam("layout[]") List<String> layouts,
			@RequestParam("cat_id[]") List<String> cat_ids
	){	
		ObjectNode objectNode = mapper.createObjectNode();
		
		if(ids == null || ids.size() == 0) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Danh sách id không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		int total = ids.size();
		if(num_posts == null || num_posts.size() != total ) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Danh sách num_post không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		if(titles == null || titles.size() != total) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Danh sách title không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		if(layouts == null || layouts.size() != total) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Danh sách layout không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		

		if(cat_ids == null || cat_ids.size() != total) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Danh sách thể loại không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		
		
		Session session = factory.openSession();
		boolean error = false;
		 for(int i=0; i< total; i++){
			int id = ids.get(i);
			int num_post = num_posts.get(i);
			String title = titles.get(i);
			String layout = layouts.get(i);
			String cat_id = cat_ids.get(i);
			
			Categories category = getCategory(cat_id);
			if(category == null) {
				error = true;
				objectNode.put("msg", "Thể loại không hợp lệ!");				
				break;
			}
			
			if(!CommonHelper.contains(new String[] { "layout-group-1", "layout-group-2", "layout-group-3", "layout-group-4", "layout-grid-1", "layout-grid-2", "layout-vertical" }, layout)) {
				error = true;
				objectNode.put("msg", "Layout không hợp lệ!");
				break;
			}
			try{   
				String hql = "UPDATE Widgets SET title = :title, layout = :layout, num_post = :num_post, category = :category WHERE id =:id";
				
				Query query = session.createQuery(hql);
				query.setParameter("title", title);
				query.setParameter("layout", layout);
				query.setParameter("num_post", num_post);
				query.setParameter("id", id);
				query.setParameter("category", category);
				query.executeUpdate();
			}
			catch(Exception e){
				e.printStackTrace();
				error = true;
				objectNode.put("msg", "Cập nhật thất bại!");
				break;
			}
		}
		 
		if(error) {
			session.close();
			objectNode.put("result", 0);
		}else {
			objectNode.put("result", 1);
			objectNode.put("msg", "Cập nhật thành công!");
		}
		
		
		return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
	}
}
