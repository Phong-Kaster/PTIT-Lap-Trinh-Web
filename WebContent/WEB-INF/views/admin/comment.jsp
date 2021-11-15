<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="format" uri="http://java.sun.com/jstl/fmt_rt" %>
<!doctype html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
      <title>Dashboard - ${ SettingsData.getSite_name() }</title>
      <meta name="description" content="${ SettingsData.getSite_description() }">
      <meta name="author" content="pixelcave">
      <meta name="robots" content="noindex, nofollow">
      <meta property="og:site_name" content="${ SettingsData.getSite_name() }">
      <meta property="og:type" content="website">
      <meta property="og:title" content="${ SettingsData.getSite_name() } - ${ SettingsData.getSite_slogan() }" />
      <meta property="og:url" content="${HOMEURL}" />
      <meta property="og:description" content="${ SettingsData.getSite_description() }" />
      <base href="${APPURL }/"/>
      <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
      <link rel="stylesheet" id="css-main" href="./public/admin/css/oneui.min.css">
      <link rel="stylesheet" href="./public/admin/js/plugins/sweetalert2/sweetalert2.min.css">
      <link rel="stylesheet" href="./public/admin/css/comment.css">
      
   </head>
   <body>
      <div id="page-container" class="sidebar-o sidebar-dark enable-page-overlay side-scroll page-header-fixed main-content-narrow remember-theme">
         <!-- SIDEBAR FRAGMENT -->
         <jsp:include page="./fragments/sidebar.fragment.jsp"/>
         <!-- HEADER FRAGMENT -->
         <jsp:include page="./fragments/header.fragment.jsp"/>
         <main id="main-container">
            <div class="bg-body-light">
               <div class="content content-full">
                  <div class="d-flex flex-column flex-sm-row justify-content-sm-between align-items-sm-center py-2">
                     <div class="flex-grow-1">
                        <h1 class="h3 fw-bold mb-0">
                           Bình luận
                        </h1>
                     </div>
                  </div>
               </div>
            </div>
            <div class="content">
               <!-- IN RA TRANG THAI VA SO LUONG BINH LUAN THUOC TRANG THAI DO -->
               <div class="sub mb-3 fs-sm">
                  <c:if test="${ commentStatusNow == 'all' }">
                     <a class=" link-fx text-primary-darker" href="${ ADMINURL }/comment.htm">
                        <strong>Tổng số (<span id="quantityTotalComment">${ totalComment }</span>)</strong>
                        </a>
                        |
                  </c:if>
                  <c:if test="${ commentStatusNow != 'all' }">
                  <a class=" link-fx" href="${ ADMINURL }/comment.htm">
                  			Tổng số (<span id="quantityTotalComment">${ totalComment }</span>)
                  </a>
                  |
                  </c:if>
                  <!-- CHAP NHAN -->
                  <c:forEach items="${listStatus}" var="element">
                     <c:if test="${ element[0] == 'approved' }">
                        <c:choose>
                           <c:when test="${ commentStatusNow == 'approved' }">
                              <a class=" link-fx text-primary-darker" href="${ ADMINURL }/comment.htm?commentStatus=approved">
                              <strong>Chấp nhận (<span id="quantityApprovedComment"> ${ element[1] } </span>)</strong>
                              </a>
                           </c:when>
                           <c:otherwise>
                              <a class=" link-fx" href="${ ADMINURL }/comment.htm?commentStatus=approved">
                              Chấp nhận (<span id="quantityApprovedComment"> ${ element[1] } </span>)
                              </a>
                           </c:otherwise>
                        </c:choose>
                        |
                     </c:if>
                  </c:forEach>
                  <!-- CHO DUYET -->
                  <c:forEach items="${listStatus}" var="element">
                     <c:if test="${ element[0] == 'pending' }">
                        <c:choose>
                           <c:when test="${ commentStatusNow == 'pending' }">
                              <a class=" link-fx text-primary-darker" href="${ ADMINURL }/comment.htm?commentStatus=pending">
                              <strong>Chờ duyệt (<span id="quantityPendingComment">  ${ element[1] } </span>)</strong>
                              </a>
                           </c:when>
                           <c:otherwise>
                              <a class=" link-fx" href="${ ADMINURL }/comment.htm?commentStatus=pending">
                              		Chờ duyệt (<span id="quantityPendingComment">  ${ element[1] } </span>)
                              </a>
                           </c:otherwise>
                        </c:choose>
                        |
                     </c:if>
                  </c:forEach>
                  <!-- THUNG RAC -->
                  <c:forEach items="${listStatus}" var="element">
                     <c:if test="${ element[0] == 'trash' }">
                        <c:choose>
                           <c:when test="${ commentStatusNow == 'trash' }">
                              <a class=" link-fx text-primary-darker" href="${ ADMINURL }/comment.htm?commentStatus=trash">
                              <strong>Thùng rác (<span id="quantityTrashComment"> ${ element[1] } </span>)</strong>
                              </a>
                           </c:when>
                           <c:otherwise>
                              <a class=" link-fx" href="${ ADMINURL }/comment.htm?commentStatus=trash">
                              		Thùng rác (<span id="quantityTrashComment"> ${ element[1] } </span>)
                              </a>
                           </c:otherwise>
                        </c:choose>
                     </c:if>
                  </c:forEach>
               </div>
               <div class="block block-rounded">
                  <div class="block-header block-header-default">
                     <!-- THANH TIM KIEM -->
                     <form action="${APPURL }/admin/search-comment-by-keyword.htm" method="post">
                        <div class="input-group">
                           <button type="submit" class="btn-search-comment btn btn-alt-primary">
                           <i class="fa fa-search me-1"></i> Tìm kiếm
                           </button>
                           <input type="text" class="form-control form-control-alt" name="keyword" placeholder="Nhập nội dung cần tìm">
                        </div>
                     </form>
                  </div>
                  <div class="block-content">
                     <table class="table table-bordered table-striped table-vcenter">
                        <thead>
                           <tr>
                              <!-- <th class="text-center" style="width: 100px;">
                                 <i class="far fa-user"></i>
                                 </th> -->
                              <th style="width: 100px;">Tác giả</th>
                              <th style="width: 20%">Nội dung</th>
                              <th style="width: 40%;">Bài viết</th>
                              <th style="width: 15%;">Ngày</th>
                              <th class="text-center" style="width: 100px;">Trạng thái</th>
                           </tr>
                        </thead>
                        <tbody id="commentBody">
                           <!-- PAGINATION - HIEN THI BAI VIET NHUNG CO PHAN TRANG -->
                           <jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder"/>
                           <c:url value="/admin/comment.htm" var="pagedLink">
                              <c:param name="p" value="~" />
                           </c:url>
                           <c:forEach items="${pagedListHolder.pageList }" var="element">
                              <tr data-uid="${element.id }">
                                
                                 <td class="fw-semibold fs-sm">
                                    <a href="${ADMINURL }/comment.htm?commentAuthor=${element.comment_author}">${ element.comment_author }</a>
                                 </td>
                                 <td class="fw-semibold fs-sm">
                                    <!-- noi dung bai viet va cac nut tuy chon -->
                                    <div class="commentcontent">
                                       ${ element.comment_content } 
                                       </br>
                                       <div class="btn-group" data-uid="${ element.id }">
                                          <c:if test="${ element.comment_status == 'pending' }">
                                             <!-- trang thai pending -->
                                             <button type="button" data-uid=${ element.id } class="btn-option btn-approve-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                                             		Chấp thuận
                                             </button>
                                             <button type="button" data-uid=${ element.id } class="btn-option btn-trash-comment btn-trash-comment btn btn-sm btn-alt-danger" data-bs-toggle="tooltip">
                                             		Thùng rác
                                             </button>
                                          </c:if>
                                          <c:if test="${ element.comment_status == 'approved' }">
                                             <!-- trang thai approved -->
                                             <a type="button" href="${APPURL }/admin/response-comment-${ element.id }.htm" class="btn-option btn-response-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                                             		Phản hồi
                                             </a>
                                             <button type="button" data-uid=${ element.id } class="btn-option btn-trash-comment btn btn-sm btn-alt-danger" data-bs-toggle="tooltip">
                                             		Thùng rác
                                             </button>
                                          </c:if>
                                          <c:if test="${ element.comment_status == 'trash'}">
                                             <!-- trang thai trash -->
                                             <button type="button" data-uid=${ element.id } class="btn-option btn-restore-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip" >
                                             		Phục hồi
                                             </button>
                                             <button type="button" data-uid=${ element.id } class="btn-option btn-remove-comment btn btn-sm btn-alt-danger" data-bs-toggle="tooltip" title="">
                                             		Xoá
                                             </button>
                                          </c:if>
                                       </div>
                                    </div>
                                 </td>
                                 <td class="fs-sm"><a target="_blank" href="${APPURL }/article/${element.post.id }/${element.post.post_slug}.htm">${ element.post.title }</a></em></td>
                                 <td>
                                    <format:formatDate value="${element.comment_date }" pattern="dd-MM-yyyy hh:mm aa" />
                                 </td>
                                 <td class="text-center" data-uid="${ element.id }">
                                    <c:if test="${ element.comment_status == 'approved' }">
                                       <span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-success-light text-success">${ element.comment_status }</span>
                                    </c:if>
                                    <c:if test="${ element.comment_status == 'pending' }">
                                       <span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-info-light text-info">${ element.comment_status }</span>
                                    </c:if>
                                    <c:if test="${ element.comment_status == 'trash' }">
                                       <span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-danger-light text-danger">${ element.comment_status }</span>
                                    </c:if>
                                 </td>
                              </tr>
                           </c:forEach>
                        </tbody>
                     </table>
                     <tg:paging_admin pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
                  </div>
               </div>
            </div>
         </main>
         <c:remove var="successMessage" scope="session" />
         <c:remove var="errorMessage" scope="session" />
         <!-- FOOTER FRAGMENT -->
         <jsp:include page="./fragments/footer.fragment.jsp"/>
      </div>
      <script src="./public/admin/js/lib/jquery.min.js"></script>
      <script src="./public/admin/js/oneui.app.min.js"></script>
      <script src="./public/admin/js/plugins/sweetalert2/sweetalert2.min.js"></script>
      <script src="./public/admin/js/pages/core.js"></script>
      <script>
      	let URL = "${ADMINURL}/";
		let CLIENTURL = "${APPURL}";
      </script>
      <script src="./public/admin/js/pages/comment.js"></script>
   </body>
</html>