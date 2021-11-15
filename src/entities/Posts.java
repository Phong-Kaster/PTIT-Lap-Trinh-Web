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
@Table(name="POSTS")
public class Posts {
	@Id @GeneratedValue
	@Column(name="ID")
	private int id;
	
	@ManyToOne( fetch=FetchType.EAGER)
	@JoinColumn(name="USER_ID", referencedColumnName="ID") 
	private Users user;
	
	@ManyToOne( fetch=FetchType.EAGER)
	@JoinColumn(name="CAT_ID", referencedColumnName="ID") 
	private Categories category;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="MM/dd/yyyy")
	@Column(name="CREATED_AT", columnDefinition = "DATETIME default getdate()")
	private Date created_at;
	
	@Column(name="CONTENT")
	private String content;
		
	@Column(name="TITLE")
	private String title;
	
	@Column(name="EXCERPT")
	private String excerpt;
	
	@Column(name="POST_STATUS")
	private String post_status;
	
	@Column(name="COMMENT_STATUS")
	private boolean comment_status;
	
	@Column(name="POST_SLUG")
	private String post_slug;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="MM/dd/yyyy")
	@Column(name="MODIFIED_AT" , columnDefinition = "DATETIME default getdate()")
	private Date modified_at;
	
	@Column(name="MEDIA")
	private String media;
	
	@Column(name="VIEWER", columnDefinition = "integer default 0")
	private long viewer;
	
	@Column(name="FEATURED", columnDefinition = "boolean default false")
	private boolean featured;
	
	@Column(name="EXTERNAL_ID")
	private String external_id;

	@Column(name="SOURCE")
	private String source;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getPost_status() {
		return post_status;
	}

	public void setPost_status(String post_status) {
		this.post_status = post_status;
	}

	public boolean isComment_status() {
		return comment_status;
	}

	public void setComment_status(boolean comment_status) {
		this.comment_status = comment_status;
	}

	public String getPost_slug() {
		return post_slug;
	}

	public void setPost_slug(String post_slug) {
		this.post_slug = post_slug;
	}

	public Date getModified_at() {
		return modified_at;
	}

	public void setModified_at(Date modified_at) {
		this.modified_at = modified_at;
	}

	public String getMedia() {
		return media;
	}

	public void setMedia(String media) {
		this.media = media;
	}

	public long getViewer() {
		return viewer;
	}

	public void setViewer(long viewer) {
		this.viewer = viewer;
	}

	public boolean isFeatured() {
		return featured;
	}

	public void setFeatured(boolean featured) {
		this.featured = featured;
	}

	public String getExternal_id() {
		return external_id;
	}

	public void setExternal_id(String external_id) {
		this.external_id = external_id;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}
	
	
}
