package models;

import java.util.List;

import entities.Comments;

public class CommentModel {
		Comments comment;
		
		List<Comments> list_children ;
		
		public CommentModel() {
			super();
			// TODO Auto-generated constructor stub
		}

		public Comments getComment() {
			return comment;
		}

		public void setComment(Comments comment) {
			this.comment = comment;
		}

		public List<Comments> getList_children() {
			return list_children;
		}

		public void setList_children(List<Comments> list_children) {
			this.list_children = list_children;
		}
		
}
