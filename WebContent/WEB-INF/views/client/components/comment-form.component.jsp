<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
  
<div class="single-component single-component-comment">
                                                <div id="comments" class="comments-area single-section single-component">
                                                   <h2 class="comments-title single-heading">
                                                      <span>
                                                     ${CountComments }	Bình luận	</span>
                                                   </h2>
                                                   
                                                    <c:set var="title" value="${post.title}" scope="request"/>
                                             		<jsp:include page="comments.component.jsp"/>
                                                   
                                                   <div id="respond" class="comment-respond">
                                                      <h3 id="reply-title" class="comment-reply-title single-heading"><span>Trả lời</span>
                                                         <small>
                                                         <a rel="nofollow" id="cancel-comment-reply-link" href="${APPURL}/article/${ post.id }/${ post.post_slug }.htm#respond" style="display:none;">Hủy</a>
                                                         </small>
                                                      </h3>
                                                      <c:if test="${success != null|| success.length == 0}">
                                                       	<div class="form-result text-l mb-40 wpcf7-response-output wpcf7-mail-sent-ok" id="alertComment">
															<em >${success}</em>
														</div>
													   </c:if>
													   
													   <c:if test="${primary != null|| primary.length == 0}">
                                                       	<div class="form-result text-l mb-40 warning" id="alertComment">
															<em >${primary}</em>
														</div>
													   </c:if>
													   
													   <c:if test="${error != null|| error.length == 0}">
                                                       	<div class="form-result text-l mb-40 " id="alertComment">
															<em class="comment-awaiting-moderation">${error}</em>
														</div>
													   </c:if>
													   
														<br/>
														
                                                      <form action="${APPURL}/article/${ post.id }/${ post.post_slug }.htm#respond" method="post" id="commentform" class="comment-form js-ajax-form">
                                                         <input type="hidden" name="action" value="comment">
                                                         <p class="comment-form-comment">
                                                            <textarea id="comment" name="comment" cols="45" rows="8" required aria-required="true" placeholder="viết bình luận..."></textarea>
                                                         </p>
                                                         <c:if test="${ AuthUser == null }">
                                                          	<p class="comment-form-author">
	                                                            <input id="author" name="author" type="text" required value="" size="30" placeholder="Name">
	                                                         </p>
	                                                         <p class="comment-form-email">
	                                                            <input id="email" name="email" type="email" required value="" size="30" placeholder="Email">
	                                                         </p>
                                                         </c:if>
                                                        
                                                        <c:if test="${ IntegrationsData.comment_recaptcha == 'true' }">
	                                                        <div class="comment-form-recaptcha">
	                                                            <div class="mb-40 recaptcha">
	                                                               <div class="g-recaptcha" data-sitekey="${ Recaptcha.getSiteKey() }"></div>
	                                                               <div class="recaptcha-error"></div>
	                                                            </div>
	                                                         </div>
                                                        </c:if>
                                                        
                                                         
                                                         <p class="form-submit">
                                                            <input name="submit" type="submit" id="submit" class="submit" value="Phản hồi" />
                                                            <input type='hidden' name='comment_post_id' value='${ post.id }' id='comment_post_id' />
                                                            <input type='hidden' name='comment_parent' id='comment_parent' value='0' />
                                                         </p>
                                                      </form>
                                                      <c:remove var="success" scope="session" />
													  <c:remove var="error" scope="session" />
													  <c:remove var="primary" scope="session" />
                                                   </div>
                                                </div>
                                             </div>