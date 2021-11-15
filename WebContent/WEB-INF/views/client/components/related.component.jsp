<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
   <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
   
<div class="single-related-wrapper single-big-section single-bottom-section single-big-section-related">
                        <div class="fox-related-posts">
                           <div class="container">
                              <h3 class="single-heading related-label related-heading">
                                 <span>Tin liên quan</span>
                              </h3>
                              <div class="blog-container blog-container-grid">
                                 <div class="wi-blog fox-blog blog-grid fox-grid blog-card-has-shadow column-4 spacing-small">
                                 
                                 	<c:forEach var="p" items="${ListRelatedPost}">
				                  		 <article class="wi-post post-item post-grid fox-grid-item post-align-left post--thumbnail-before post-1396 post type-post status-publish format-standard has-post-thumbnail hentry category-travel tag-article tag-blog tag-gutenberg tag-instagram tag-times no-sidebar">
	                                       <div class="post-item-inner grid-inner post-grid-inner">
	                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade">
	                                             <div class="thumbnail-inner">
	                                                <a href="${ APPURL }/article/${ p.id }/${ p.post_slug }.htm" class="post-link">
	                                                <span class="image-element">
	                                                <img width="480" height="384" srcset="${ p.media }" class="attachment-thumbnail-medium size-thumbnail-medium" alt="" loading="lazy" />
	                                                </span>
	                                                </a>
	                                             </div>
	                                          </figure>
	                                          <div class="post-body post-item-body grid-body post-grid-body">
	                                             <div class="post-body-inner">
	                                                <div class="post-item-header">
	                                                   <div class="post-item-meta wi-meta fox-meta post-header-section ">
	                                                      <div class="entry-date meta-time machine-time time-short">
	                                                         <time class="published">${dateFormat.format(p.modified_at) }</time>
	                                                      </div>
	                                                   </div>
	                                                   <h3 class="post-item-title wi-post-title fox-post-title post-header-section size-tiny">
	                                                      <a href="${ APPURL }/article/${ p.id }/${ p.post_slug }.htm" rel="bookmark">
	                                                      ${ p.title } </a>
	                                                   </h3>
	                                                </div>
	                                             </div>
	                                          </div>
	                                       </div>
	                                    </article>
	                                    
									</c:forEach>
                                   
                                    
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>