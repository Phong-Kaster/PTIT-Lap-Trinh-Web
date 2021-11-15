<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
</head>
<body>
<div id="page-container" class="sidebar-o sidebar-dark enable-page-overlay side-scroll page-header-fixed main-content-narrow remember-theme ">
    
  <!-- SIDEBAR FRAGMENT -->
  <jsp:include page="./fragments/sidebar.fragment.jsp"/>

  <!-- HEADER FRAGMENT -->
  <jsp:include page="./fragments/header.fragment.jsp"/>
  
  
  <main id="main-container">
<div class="content">
  <div class="d-flex flex-column flex-md-row justify-content-md-between align-items-md-center py-2 text-center text-md-start">
    <div class="flex-grow-1 mb-1 mb-md-0">
      <h1 class="h3 fw-bold mb-2">
        Dashboard
      </h1>
      <h2 class="h6 fw-medium fw-medium text-muted mb-0">
        Xin chào <a class="fw-semibold" href="${APPURL }/admin/profile.htm">${ AuthUser.firstname } ${ AuthUser.lastname }</a>.
      </h2>
    </div>
    <div class="mt-3 mt-md-0 ms-md-3 space-x-1">
    	<c:if test="${ AuthUser.account_type == 'ADMIN' }">
    		<a class="btn btn-sm btn-alt-secondary space-x-1" href="${ ADMINURL }/settings/site.htm">
	        <i class="fa fa-cogs opacity-50"></i>
	        <span>Settings</span>
	      </a>
    	</c:if>
    </div>
  </div>
</div>
<div class="content">
  <div class="row items-push">
    <div class="col-sm-6 col-xxl-3">
      <div class="block block-rounded d-flex flex-column h-100 mb-0">
        <div class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
          <dl class="mb-0">
            <dt class="fs-3 fw-bold">${count.post }</dt>
            <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">Bài viết</dd>
          </dl>
          <div class="item item-rounded-lg bg-body-light">
            <i class="far fa-edit fs-3 text-primary"></i>
          </div>
        </div>
        <div class="bg-body-light rounded-bottom">
          <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between" href="${ADMINURL}/posts.htm">
            <span>Xem tất cả bài viết</span>
            <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
          </a>
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xxl-3">
      <div class="block block-rounded d-flex flex-column h-100 mb-0">
        <div class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
          <dl class="mb-0">
            <dt class="fs-3 fw-bold">${count.cat }</dt>
            <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">Thể loại</dd>
          </dl>
          <div class="item item-rounded-lg bg-body-light">
            <i class="fa fa-tags fs-3 text-primary"></i>
          </div>
        </div>
        <div class="bg-body-light rounded-bottom">
          <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between" href="${ADMINURL}/categories.htm">
            <span>Xem tất cả thể loại</span>
            <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
          </a>
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xxl-3">
      <div class="block block-rounded d-flex flex-column h-100 mb-0">
        <div class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
          <dl class="mb-0">
            <dt class="fs-3 fw-bold">${count.cmt }</dt>
            <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">Bình luận</dd>
          </dl>
          <div class="item item-rounded-lg bg-body-light">
            <i class="far fa-comments fs-3 text-primary"></i>
          </div>
        </div>
        <div class="bg-body-light rounded-bottom">
          <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between" href="${ADMINURL}/comment.htm">
            <span>Xem tất cả bình luận</span>
            <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
          </a>
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xxl-3">
      <div class="block block-rounded d-flex flex-column h-100 mb-0">
        <div class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
          <dl class="mb-0">
            <dt class="fs-3 fw-bold">${count.user }</dt>
            <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">Thành viên</dd>
          </dl>
          <div class="item item-rounded-lg bg-body-light">
            <i class="fa fa-user-circle fs-3 text-primary"></i>
          </div>
        </div>
        <div class="bg-body-light rounded-bottom">
          <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between" href="${ADMINURL}/users.htm">
            <span>Xem tất cả thành viên</span>
            <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
          </a>
        </div>
      </div>
    </div>
  </div>
    

</div>
  </main>
  
  <!-- FOOTER FRAGMENT -->
  <jsp:include page="./fragments/footer.fragment.jsp"/>
  
</div>
		<script src="./public/admin/js/oneui.app.min.js"></script>
		<script src="./public/admin/js/lib/jquery.min.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
  </body>
</html>