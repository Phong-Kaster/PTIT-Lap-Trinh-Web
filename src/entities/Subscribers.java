package entities;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="SUBSCRIBERS")	
public class Subscribers {
	@Id 
	@Column(name="EMAIL")
	private String email;
	
	@Column(name="IS_ACTIVE")
	private boolean is_active;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="MM/dd/yyyy")
	@Column(name="UPDATED_AT")
	private Date updated_at;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="MM/dd/yyyy")
	@Column(name="CREATED_AT")
	private Date created_at;
	
	@Column(name="DATA")
	private String data;
	
	
	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public boolean isIs_active() {
		return is_active;
	}


	public void setIs_active(boolean is_active) {
		this.is_active = is_active;
	}


	public Date getUpdated_at() {
		return updated_at;
	}


	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}


	public Date getCreated_at() {
		return created_at;
	}


	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}


	public String getData() {
		return data;
	}


	public void setData(String data) {
		this.data = data;
	}


	public Subscribers createSub(String email)
	{
		Subscribers newSub = new Subscribers();
		newSub.setEmail(email);
		newSub.setIs_active(true);
		LocalDateTime now = LocalDateTime.now();  
		Date current = java.sql.Timestamp.valueOf(now); 
		newSub.setUpdated_at(current);
		newSub.setCreated_at(current);
		newSub.setData("{}");
		return newSub;
	}
	
}
