package entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="PAGES")
public class Pages {
	@Id @GeneratedValue
	@Column(name="ID")
	private int id;
	
	@ManyToOne( fetch=FetchType.LAZY)
	@JoinColumn(name="USER_ID", referencedColumnName="ID")
	private Users user;

	@Column(name="TITLE")
	private String title;
	
	@Column(name="EXCERPT")
	private String excerpt;
	
	@Column(name="PAGE_SLUG")
	private String page_slug;
	
	@Column(name="CONTENT")
	private String content;
		
	@Column(name="PAGE_STATUS")
	private String page_status;
	
	@Column(name="VIEWER")
	private long viewer;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="MM/dd/yyyy")
	@Column(name="CREATED_AT")
	private Date created_at;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="MM/dd/yyyy")
	@Column(name="MODIFIED_AT")
	private Date modified_at;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getExcerpt() {
		return excerpt;
	}

	public void setExcerpt(String excerpt) {
		this.excerpt = excerpt;
	}

	public String getPage_slug() {
		return page_slug;
	}

	public void setPage_slug(String page_slug) {
		this.page_slug = page_slug;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPage_status() {
		return page_status;
	}

	public void setPage_status(String page_status) {
		this.page_status = page_status;
	}

	public long getViewer() {
		return viewer;
	}

	public void setViewer(long viewer) {
		this.viewer = viewer;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public Date getModified_at() {
		return modified_at;
	}

	public void setModified_at(Date modified_at) {
		this.modified_at = modified_at;
	}
	
	
}
