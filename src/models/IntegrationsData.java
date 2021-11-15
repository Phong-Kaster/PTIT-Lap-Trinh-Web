package models;

import java.io.Serializable;

public class IntegrationsData implements Serializable {

	private static final long serialVersionUID = 1L;
	private String property_id;
	private boolean comment_recaptcha;
	
	public String getProperty_id() {
		return property_id;
	}						
	public void setProperty_id(String property_id) {
		this.property_id = property_id;
	}
	public boolean isComment_recaptcha() {
		return comment_recaptcha;
	}
	public void setComment_recaptcha(boolean comment_recaptcha) {
		this.comment_recaptcha = comment_recaptcha;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
