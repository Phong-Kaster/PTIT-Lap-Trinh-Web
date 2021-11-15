<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <div class="wi-section fox-section section-layout-group-3 section-stretch-content show_on_desktop show_on_tablet show_on_mobile section-fullwidth section-has-heading">
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
                           <div class="blog-container blog-container-group blog-container-group-2">
                              <div class="wi-blog fox-blog blog-group blog-group-2 post-group-row newsblock-2 post-group-row-1b-3-1a big-order-3 small-order-2 tall-order-1 post-group-spacing-normal has-border">
                                 <div class="post-group-col post-group-col-big article-col-big">
                                 <c:forEach var="post" items="${ posts }" begin="0" end="0">
                                    <article class="wi-post post-item post-grid fox-grid-item article-big post-align-left post--thumbnail-before post-16 post type-post status-publish format-standard has-post-thumbnail hentry category-politics tag-interview tag-news tag-opinion tag-wordpress tag-world">
                                       <div class="post-item-inner grid-inner post-grid-inner">
                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute hover-none">
                                             <div class="thumbnail-inner">
                                                <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
                                                <span class="image-element">
                                                <img width="720" height="480" alt="" loading="lazy" srcset="${ post.media }">
                                                </span>
                                                </a>
                                             </div>
                                          </figure>
                                          <div class="post-body post-item-body grid-body post-grid-body">
                                             <div class="post-body-inner">
                                                <div class="post-item-header">
                                                   <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                      <div class="entry-date meta-time machine-time time-short">
                                                         <time class="published">${dateFormat.format(post.modified_at) }</time>
                                                      </div>
                                                      <div class="entry-categories meta-categories categories-plain">
                                                         <a href="${ APPURL }/category/${ category.slug }.htm" rel="tag">${ category.name }</a>
                                                      </div>
                                                   </div>
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-medium">
                                                      <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">
                                                      ${ post.title } </a>
                                                   </h2>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-normal custom-color" style="color:#797979">
                                                   ${ post.excerpt }
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </article>
                                    </c:forEach>
                                 </div>
                                 <div class="post-group-col post-group-col-tall article-col-tall">
                                    <c:forEach var="post" items="${ posts }" begin="1" end="1">
                                    <article class="wi-post post-item post-grid fox-grid-item article-tall article-medium post-align-left post--thumbnail-before post-11 post type-post status-publish format-standard has-post-thumbnail hentry category-politics category-world tag-journal tag-opinion tag-politics tag-travel tag-world">
                                       <div class="post-item-inner grid-inner post-grid-inner">
                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute  hover-none">
                                             <div class="thumbnail-inner">
                                                <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
                                                <span class="image-element">
                                                <img width="300" height="200" class="attachment-medium size-medium" alt="" loading="lazy" srcset="${ post.media }">
                                                </span>
                                                </a>
                                             </div>
                                          </figure>
                                          <div class="post-body post-item-body grid-body post-grid-body">
                                             <div class="post-body-inner">
                                                <div class="post-item-header">
                                                   <div class="entry-categories meta-categories categories-plain standalone-categories post-header-section">
                                                      <a href="${ APPURL }/category/${ category.slug }.htm" rel="tag">${ category.name }</a>
                                                   </div>
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-normal">
                                                     <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">
                                                      ${ post.title } </a>
                                                   </h2>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-normal custom-color" style="color:#797979">
                                                  ${ post.excerpt }
                                                </div>
                                                <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                   <div class="entry-date meta-time machine-time time-short">
                                                      <time class="published">${dateFormat.format(post.modified_at) }</time>
                                                   </div>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </article>
                                    </c:forEach>
                                 </div>
                                 <div class="post-group-col post-group-col-small article-col-small">
                                    <c:forEach var="post" items="${ posts }" begin="2">
                                    <article class="wi-post post-item post-grid fox-grid-item article-small article-small-grid post-align-left post--thumbnail-before post type-post status-publish format-standard has-post-thumbnail hentry category-politics tag-journal tag-newspaper tag-travel tag-wordpress tag-world">
                                       <div class="post-item-inner grid-inner post-grid-inner">
                                          <div class="post-body post-item-body grid-body post-grid-body">
                                             <div class="post-body-inner">
                                                <div class="post-item-header">
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-small" >
                                                     <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">
                                                      ${ post.title } </a>
                                                   </h2>
                                                   <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                      <div class="entry-categories meta-categories categories-plain">
                                                         <a href="${ APPURL }/category/${ category.slug }.htm" rel="tag">${ category.name }</a>
                                                      </div>
                                                   </div>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-small custom-color" style="color:#797979">
                                                  ${ post.excerpt }
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </article>
                                   </c:forEach>
                                   
                                 
                                 </div>
                                 <div class="sep-border line1" style="color:#e0e0e0"></div>
                                 <div class="sep-border line2" style="color:#e0e0e0"></div>
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