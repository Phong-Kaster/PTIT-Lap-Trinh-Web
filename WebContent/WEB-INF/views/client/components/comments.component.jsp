<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<ol class="commentlist">

<c:forEach var="item" items="${ listComments }"> 
	<li id="comment-${item.comment.id}" class="comment">
		<article id="div-comment-${item.comment.id}" class="comment-body">
			<footer class="comment-meta">
				<div class="comment-author vcard">
					<img alt="" src="./public/images/users/no-avatar.png" srcset="./public/images/users/no-avatar.png 2x" class="avatar avatar-120 photo" height="120" width="120" loading="lazy"> <b class="fn">${ item.comment.comment_author }</b> <span class="says">viết:</span>
				</div>
				
				<div class="comment-metadata">
					<a href="${APPURL }/post/${post.id }/${post.post_slug }.htm#comment-${item.comment.id}">
						<time>${item.comment.comment_date}</time>
					</a>
				</div>
				
			</footer>
			
			<div class="comment-content">
			<p> ${item.comment.comment_content }</p>
			</div>
			
			<div class="reply"><a rel="nofollow" class="comment-reply-link" href="${APPURL }/post/${post.id }/${post.post_slug }.htm#comment-${item.comment.id}?replytocom=${item.comment.id }#respond" data-commentid="${item.comment.id }" data-postid="${post.id }" data-belowelement="div-comment-${item.comment.id }" data-respondelement="respond" data-replyto="Phản hồi đến ${item.comment.comment_author }" aria-label="Phản hồi đến ${item.comment.comment_author }">Trả lời</a></div>
		</article>
		<c:if test="${item.list_children != null && item.list_children.size() > 0}">
		<ul class="children">
			<c:forEach var="child" items="${ item.list_children }"> 
				<li id="comment-${ child.id }" class="comment odd alt depth-2">
					<article id="div-${ child.id }" class="comment-body">
						<footer class="comment-meta">
							<div class="comment-author vcard">
								<img alt="" src="./public/images/users/no-vatar.png" srcset="./public/images/users/no-vatar.png 2x" class="avatar avatar-120 photo" height="120" width="120" loading="lazy"> <b class="fn">${ child.comment_author }</b> <span class="says">viết:</span>
							</div>
							 
							<div class="comment-metadata">
								<a href="${APPURL }/post/${post.id }/${post.post_slug }.htm#comment-${ child.id }">
									<time>${ child.comment_date}</time>
								</a>
							
							</div>
							
						</footer>
						
						<div class="comment-content">
							<p>${child.comment_content}</p>
						</div>
					
					</article>
					
				</li>
			</c:forEach>
	 
		</ul>
		</c:if>
	</li>
</c:forEach>
</ol>