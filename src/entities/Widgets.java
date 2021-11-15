package entities;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="WIDGETS")
public class Widgets {

	@Id @GeneratedValue
	@Column(name="ID")
	private int id;
		
	@Column(name="TITLE")
	private String title;
	
	@ManyToOne( fetch=FetchType.EAGER)
	@JoinColumn(name="CAT_ID", referencedColumnName="ID")
	private Categories category;
	
	@Column(name="LAYOUT")
	private String layout;
	
	@Column(name="ORDER_WIDGET")
	private int order_widget;
	
	@Column(name="NUM_POST")
	private int num_post;

	
	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}


	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

	public int getOrder_widget() {
		return order_widget;
	}

	public void setOrder_widget(int order_widget) {
		this.order_widget = order_widget;
	}

	public int getNum_post() {
		return num_post;
	}

	public void setNum_post(int num_post) {
		this.num_post = num_post;
	}
	
	
	
}
