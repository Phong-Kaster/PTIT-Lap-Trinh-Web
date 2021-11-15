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
@Table(name="COMMENTS")
public class Comments {
	@Id @GeneratedValue
	@Column(name="Id")
	private int id;
	
	@ManyToOne( fetch=FetchType.EAGER)
	@JoinColumn(name="POST_ID")
	private Posts post;

	@Column(name="COMMENT_AUTHOR")
	private String comment_author;
	
	@Column(name="COMMENT_AUTHOR_EMAIL")
	private String comment_author_email;
	
	@Column(name="COMMENT_AUTHOR_IP")
	private String comment_author_ip;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="MM/dd/yyyy")
	@Column(name="COMMENT_DATE")
	private Date comment_date;
	
	@Column(name="COMMENT_CONTENT")
	private String comment_content;
	
	@Column(name="COMMENT_STATUS")
	private String comment_status;
	
	@Column(name="COMMENT_AGENT")
	private String comment_agent;
	
	@Column(name="COMMENT_PARENT")
	private int comment_parent;
	
	@Column(name="USER_ID")
	private int user_id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Posts getPost() {
		return post;
	}

	public void setPost(Posts post) {
		this.post = post;
	}

	public String getComment_author() {
		return comment_author;
	}

	public void setComment_author(String comment_author) {
		this.comment_author = comment_author;
	}

	public String getComment_author_email() {
		return comment_author_email;
	}

	public void setComment_author_email(String comment_author_email) {
		this.comment_author_email = comment_author_email;
	}

	public String getComment_author_ip() {
		return comment_author_ip;
	}

	public void setComment_author_ip(String comment_author_ip) {
		this.comment_author_ip = comment_author_ip;
	}

	public Date getComment_date() {
		return comment_date;
	}

	public void setComment_date(Date comment_date) {
		this.comment_date = comment_date;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getComment_status() {
		return comment_status;
	}

	public void setComment_status(String comment_status) {
		this.comment_status = comment_status;
	}

	public String getComment_agent() {
		return comment_agent;
	}

	public void setComment_agent(String comment_agent) {
		this.comment_agent = comment_agent;
	}

	public int getComment_parent() {
		return comment_parent;
	}

	public void setComment_parent(int comment_parent) {
		this.comment_parent = comment_parent;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Comments(int id, Posts post, String comment_author, String comment_author_email, String comment_author_ip,
			Date comment_date, String comment_content, String comment_status, String comment_agent, int comment_parent,
			int user_id) {
		super();
		this.id = id;
		this.post = post;
		this.comment_author = comment_author;
		this.comment_author_email = comment_author_email;
		this.comment_author_ip = comment_author_ip;
		this.comment_date = comment_date;
		this.comment_content = comment_content;
		this.comment_status = comment_status;
		this.comment_agent = comment_agent;
		this.comment_parent = comment_parent;
		this.user_id = user_id;
	}

	public Comments() {
		super();
	}
	
	
}
