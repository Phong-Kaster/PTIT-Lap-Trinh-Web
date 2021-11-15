package models;

import java.io.Serializable;

public class SettingsData implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String site_name;
	private String site_slogan;
	private String site_description;
	private String site_keywords;
	private String logomark;
	private String logotype;
	
	public String getSite_name() {
		return site_name;
	}
	public void setSite_name(String site_name) {
		this.site_name = site_name;
	}
	public String getSite_slogan() {
		return site_slogan;
	}
	public void setSite_slogan(String site_slogan) {
		this.site_slogan = site_slogan;
	}
	public String getSite_description() {
		return site_description;
	}
	public void setSite_description(String site_description) {
		this.site_description = site_description;
	}
	public String getSite_keywords() {
		return site_keywords;
	}
	public void setSite_keywords(String site_keywords) {
		this.site_keywords = site_keywords;
	}
	public String getLogomark() {
		return logomark;
	}
	public void setLogomark(String logomark) {
		this.logomark = logomark;
	}
	public String getLogotype() {
		return logotype;
	}
	public void setLogotype(String logotype) {
		this.logotype = logotype;
	}
	
	
}
