<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
    <div class="wi-section fox-section section-layout-grid section-stretch-content show_on_desktop show_on_tablet show_on_mobile section-fullwidth section-has-heading">
         <div class="section-heading heading-link--inheading heading-line heading-line-2 heading-line-middle heading-line-stretch-content heading-tiny align-left">
            <div class="container">
               <div class="heading-inner">
                  <h2 class="heading-text"><a href="${ APPURL }/category/${ category.slug }.htm" target="_self">${ category.name }</a></h2>
                  <div class="line line-l"></div>
                  <div class="line line-r"></div>
               </div>
            </div>
         </div>
         <div class="container">
            <div class="section-container">
               <div class="section-inner">
                  <div class="section-primary">
                     <div class="theiaStickySidebar">
                        <div class="section-main">
                           <div class="blog-container blog-container-grid blog-container-has-border">
                              <div class="wi-blog fox-blog blog-grid fox-grid blog-card-has-shadow column-5 spacing-normal">
                              	<c:forEach var="post" items="${ posts }">
                                 <article class="wi-post post-item post-grid fox-grid-item post-align-left post--thumbnail-before post type-post status-publish format-standard has-post-thumbnail hentry category-business tag-newspaper tag-publishing tag-technology">
                                    <div class="post-item-inner grid-inner post-grid-inner">
                                       <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade">
                                          <div class="thumbnail-inner">
                                             <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
	                                             <span class="image-element">
	                                             	<img width="480" height="384" src="${ post.media }" class="attachment-thumbnail-medium size-thumbnail-medium" alt="" loading="lazy" />
	                                             </span>
                                             </a>
                                          </div>
                                       </figure>
                                       <div class="post-body post-item-body grid-body post-grid-body">
                                          <div class="post-body-inner">
                                             <div class="post-item-header">
                                                <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-small">
                                                   <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">${ post.title } </a>
                                                </h2>
                                             </div>
                                             <div class="post-item-excerpt entry-excerpt excerpt-size-normal">
                                                ${ post.excerpt }
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </article>
                                 </c:forEach>
                                
                                 
                                 
                                 <div class="fox-grid grid-lines column-5" style="color:#e0e0e0">
                                    <div class="grid-line fox-grid-item">
                                       <div class="grid-line-inner"></div>
                                    </div>
                                    <div class="grid-line fox-grid-item">
                                       <div class="grid-line-inner"></div>
                                    </div>
                                    <div class="grid-line fox-grid-item">
                                       <div class="grid-line-inner"></div>
                                    </div>
                                    <div class="grid-line fox-grid-item">
                                       <div class="grid-line-inner"></div>
                                    </div>
                                    <div class="grid-line fox-grid-item">
                                       <div class="grid-line-inner"></div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="clearfix"></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>