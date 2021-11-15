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
      <style>
         .btn-option{
         display:none;
         }
         .commentcontent:hover .btn-option{
         display:block;
         transition-duration: 5s;  
         }
         center {
         margin: auto;
         width: 60%;
         padding: 20px;
         box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
         }
         .hideform {
         display: none;
         }
         .divider{
         width:10px;
         height:auto;
         display:inline-block;
         }
      </style>
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
               <!-- trang thai tong so -->
               <div class="sub mb-3 fs-sm">
                  <c:if test="${ commentStatusNow == 'all' }">
                     <a class=" link-fx text-primary-darker" href="${ ADMINURL }/comment.htm">
                        <strong>Tổng số (<span id="quantityTotalComment">${ totalComment }</span>)|</strong>
                  </c:if>
                  <c:if test="${ commentStatusNow != 'all' }">
                  <a class=" link-fx" href="${ ADMINURL }/comment.htm">
                  Tổng số(<span id="quantityTotalComment">${ totalComment }</span>)
                  </a>
                  </c:if>
                  <!-- trang thai chap thuan -->
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
                  <!-- trang thai cho duyet -->
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
                  <!-- trang thai thung rac -->
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
                     <!-- thanh tim kiem -->
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
                     <tbody id="commentBody">
                        <!-- form phan hoi binh luan - moi the <tr> deu co 1 form nhu nay -->
                        <div class="center col-xs-4">
                           <a class="btn-close-response" style="float: right;" title="Đóng" href="${APPURL }/admin/comment.htm"><i class="fa fa-fw fa-times"></i></a>
                           <form action="${APPURL }/admin/response-comment-${comment.id}.htm" method="POST">
                              <div class="form-group">
                                 <label for="exampleInputEmail1">Bài viết</label>
                                 <input class="form-control" type="text" placeholder="${ comment.post.title }" readonly>
                              </div>
                              <br/>
                              <a class="col-sm-1 btn btn-warning btn-sm" href="${APPURL }/article/${comment.post.id }/${comment.post.post_slug}.htm" target="_blank">Truy cập</a>
                              <br/>
                              <br/>
                              <div class="form-group">
                                 <label for="exampleInputEmail1">Người dùng</label>
                                 <input class="form-control" type="text" placeholder="${ comment.comment_author }" readonly>
                              </div>
                              <br/>
                              <div class="form-group">
                                 <label for="exampleInputEmail1">Bình luận</label>
                                 <input class="form-control" type="text" placeholder="${ comment.comment_content }" readonly>
                              </div>
                              <br/>
                              <div class="form-group">
                                 <label for="exampleInputEmail1">Bình luận của bạn</label>
                                 <textarea id="content" class="form-control" name="content" rows="10" cols="40"></textarea>
                              </div>
                              <br/>
                              <div class="text-center">
                                 <input type="button" data-uid="${ comment.id }" class="btn-confirm-response-comment btn btn-primary" value="Lưu lại">
                                 <div class="divider"></div>
                                 <input type="button" class="btn-cancel-response-comment btn- btn btn-danger" value="Hủy bỏ">
                              </div>
                           </form>
                        </div>
                     </tbody>
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
      <script>
      	let URL = "${ADMINURL}";
		let CLIENTURL = "${APPURL}";
      </script>
      <script src="./public/admin/js/pages/comment.js"></script>
      <script src="./public/admin/js/pages/core.js"></script>
   </body>
</html>