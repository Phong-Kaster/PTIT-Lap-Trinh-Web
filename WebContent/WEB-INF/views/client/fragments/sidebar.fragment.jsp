<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@page import="helpers.CommonHelper"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
 <aside class="section-secondary section-sidebar secondary">
   <div class="theiaStickySidebar">
      <div class="widget-area">
         <div id="latest-posts-1" class="widget widget_latest_posts">
            <h3 class="widget-title"><span>Tin Nóng</span></h3>
            <div class="wi-blog fox-blog blog-list blog-widget blog-widget-small v-spacing-small blog-card-has-shadow">
               
              <c:forEach var="element" items="${ mostPopularArticle }" begin="0" end="5">
              
              	<article class="wi-post post-item post-list post-thumbnail-align-left post-valign-top list-mobile-layout-list post type-post status-publish format-standard has-post-thumbnail hentry category-opinion tag-article tag-breaking-news tag-publishing tag-times tag-travel tag-wp">
                  <div class="post-list-sep" style="border-color:#eaeaea"></div>
                  <div class="post-item-inner list-inner post-list-inner">
                     <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  list-thumbnail thumbnail-acute  hover-none">
                        <div class="thumbnail-inner">
                           <a href="${APPURL}/article/${element.id}/${element.post_slug}.htm" class="post-link">
                           <span class="image-element">
                           <img width="480" height="480" src="${ element.media }" class="attachment-thumbnail-square size-thumbnail-square" alt="" loading="lazy" srcset="${ element.media }" />
                           </span>
                           </a>
                        </div>
                     </figure>
                     <div class="post-body post-item-body list-body post-list-body">
                        <div class="post-body-inner">
                           <div class="post-item-header">
                              <h3 class="post-item-title wi-post-title fox-post-title post-header-section latest-title size-tiny">
                                 <a href="${APPURL}/article/${element.id}/${element.post_slug}.htm" rel="bookmark">
                                 ${ element.title } </a>
                              </h3>
                           </div>
                           <div class="post-item-excerpt entry-excerpt excerpt-size-normal" itemprop="text">
                              <p>${ element.excerpt }</p>
                           </div>
                        </div>
                     </div>
                  </div>
               </article>
               
              </c:forEach>
               
               
               
            </div>
         </div>
         <div id="coronavirus-2" class="widget widget_coronavirus">
            <h3 class="widget-title"><span>Cập Nhật COVID</span></h3>
            <div class="fox-coronavirus">
               <div class="coronavirus-inner">
                  <div class="coronavirus-big-numbers">
                     <div class="number-cases big-number">
                     
                        <span class="num" title="${covidworld[0]}">${CommonHelper.formatBigNumber(covidworld[0],0) }</span>
                        <span class="num-today">+${CommonHelper.formatBigNumber(covidworld[1],0) } today</span>
                        <span class="num-label">Ca nhiễm</span>
                     </div>
                     <div class="number-deaths big-number">
                        <span class="num">${CommonHelper.formatBigNumber(covidworld[2],0) }</span>
                        <span class="num-today">+${CommonHelper.formatBigNumber(covidworld[3],0) } today</span>
                        <span class="num-label">Ca tử vong</span>
                     </div>
                  </div>
                  <div class="coronavirus-table-outer">
                     <div class="t-row-th">
                        <div class="th th-name">Nước</div>
                        <div class="th th-case">Ca Nhiễm</div>
                        <div class="th th-death">Ca Tử Vong</div>
                     </div>
                     <div class="coronavirus-table-wrapper">
                        <div class="coronavirus-table-container">
                           <div class="coronavirus-table ">
                           	<c:forEach var="child" items="${covidlist}"> 
                              <div class="t-row">
                                 <div class="td td-name">${child.country }</div>
                                 <div class="td td-case">${CommonHelper.formatNumber(child.cases) }</div>
                                 <div class="td td-death">${CommonHelper.formatNumber(child.deaths) }</div>
                              </div>
                              </c:forEach>
                              
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="coronavirus-source">
                     <span>Source: <a href="https://corona.lmao.ninja/" target="_blank">disease.sh - Open Disease Data API</a> </span>
                  </div>
               </div>
            </div>
         </div>
         <div class="gutter-sidebar"></div>
      </div>
   </div>
</aside>