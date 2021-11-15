package models;

import java.io.Serializable;

public class UserSettings implements Serializable {

	private static final long serialVersionUID = 1L;
	private String facebook;
	private String pinterest;
	private String tumblr;
	private String vkontakte;
	private String whatsapp;
	private String telegram;
	private String twitter;
	private String youtube;
	public String getTwitter() {
		return twitter;
	}
	public void setTwitter(String twitter) {
		this.twitter = twitter;
	}
	public String getYoutube() {
		return youtube;
	}
	public void setYoutube(String youtube) {
		this.youtube = youtube;
	}
	public String getInstagram() {
		return instagram;
	}
	public void setInstagram(String instagram) {
		this.instagram = instagram;
	}
	private String instagram;
	
	public String getFacebook() {
		return facebook;
	}
	public void setFacebook(String facebook) {
		this.facebook = facebook;
	}
	public String getPinterest() {
		return pinterest;
	}
	public void setPinterest(String pinterest) {
		this.pinterest = pinterest;
	}
	public String getTumblr() {
		return tumblr;
	}
	public void setTumblr(String tumblr) {
		this.tumblr = tumblr;
	}
	public String getVkontakte() {
		return vkontakte;
	}
	public void setVkontakte(String vkontakte) {
		this.vkontakte = vkontakte;
	}
	public String getWhatsapp() {
		return whatsapp;
	}
	public void setWhatsapp(String whatsapp) {
		this.whatsapp = whatsapp;
	}
	public String getTelegram() {
		return telegram;
	}
	public void setTelegram(String telegram) {
		this.telegram = telegram;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}