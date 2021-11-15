<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>${ user.username == null ? 'Thêm mới người dùng' : 'Chỉnh sửa người dùng' } - ${ SettingsData.getSite_name() }</title>
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
<div id="page-container" class="sidebar-o sidebar-dark enable-page-overlay side-scroll page-header-fixed">
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
	          Chỉnh sửa ${user.firstname } ${ user.lastname }
	        </h1>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="content">
		 <div class="row">
		 	 <div class="col-lg-8 col-xl-7 col-md-9 col-sm-12">
			  <div class="block block-rounded">
			    <div class="block-header block-header-default">
			      <h3 class="block-title">${user.firstname } ${ user.lastname }</h3>
			    </div>
			    <div class="block-content block-content-full">
			      <form action="${ADMINURL }/user.htm?userid=${ user.id }" method="POST" class="js-validation">			       
			         	<c:if test="${successMessage != null && successMessage.trim().length() > 0 }">
							<div class="alert alert-success alert-dismissible" role="alert">
					            <p class="mb-0">
					              ${ successMessage } 
					            </p>
					            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				          	</div>
						</c:if>
						
						<c:if test="${errorMessage != null && errorMessage.size() > 0 }">
							<c:forEach var="error" items="${ errorMessage }">
								<div class="alert alert-danger alert-dismissible" role="alert">
						            <p class="mb-0">
						              ${ error }
						            </p>
						            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					          	</div>
							</c:forEach>
						</c:if>
			            <div class="mb-4">
			              <label class="col-sm-2 col-form-label text-right">Tên đăng nhập</label>
			              <input type="text" class="form-control" id="username" name="username" placeholder="Tên đăng nhập" value="${ user.username }" required ${ user.username != null ? 'disabled':'' }>
			            </div>
			           <div class="mb-4">
			              <label class="col-sm-2 col-form-label text-right">Email</label>
			              <input type="email" class="form-control" id="email" name="email" placeholder="Email" value="${ user.email }" required ${ user.email != null ? 'disabled':'' }>
			            </div>
			            <div class="mb-4">
			              <label class="col-sm-2 col-form-label text-right">Họ</label>
			              <input type="text" class="form-control" id="firstname" name="firstname" placeholder="Họ" value="${ user.firstname }" required>
			            </div>
			            <div class="mb-4">
			              <label class="col-sm-2 col-form-label text-right">Tên</label>
			              <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Tên" value="${ user.lastname }" required>
			            </div>
			            
			             <div class="mb-4">
			              <label class="col-sm-2 col-form-label text-right">Mật khẩu</label>
			              <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu">
			            </div>
			            
			            <div class="mb-4">
			              <label class="col-sm-2 col-form-label text-right">Mật khẩu xác nhận</label>
			              <input type="password" class="form-control" id="password_confirm" name="password_confirm" placeholder="Mật khẩu xác nhận">
			            </div>
			            
			            <div class="mb-4">
				              <label class="form-label" for="account_type">Vai trò</label>
				              <select class="form-select" id="account_type" name="account_type">
				                <option value="" disabled="">Chọn vai trò</option>
				                <option value="ADMIN" ${ user.account_type == 'ADMIN' ? 'selected' : '' }>Quản trị viên</option>
				                <option value="EDITOR" ${ user.account_type == 'EDITOR' ? 'selected' : '' }>Biên tập viên</option>
				                <option value="CONTRIBUTOR" ${ user.account_type == 'CONTRIBUTOR' ? 'selected' : '' }>Cộng tác viên</option>
				              </select>
				          </div>
				            
			             <div class="form-check mb-4">
			                <input class="form-check-input" type="checkbox" value="true" id="is_active" name="is_active" ${ user.is_active ? 'checked' : '' }>
			                <label class="form-check-label" for="is_active">Tình trạng hoạt động</label>
			            </div>
			            
			        <button type="submit" class="btn btn-success text-right">Lưu</button>
			        
			        
			        
			      </form>
			    </div>
			  </div>
		  	</div>
		 </div>
	</div>
  </main>
 <c:remove var="successMessage" scope="session" />
  <c:remove var="errorMessage" scope="session" />
  <!-- FOOTER FRAGMENT -->
      <jsp:include page="./fragments/footer.fragment.jsp"/>
      

</div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="./public/admin/js/oneui.app.min.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
		
  </body>
</html>