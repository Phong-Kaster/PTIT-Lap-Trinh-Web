<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
   
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>${AuthUser.firstname } ${AuthUser.lastname } - ${ SettingsData.getSite_name() }</title>
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
<div id="page-container" class="sidebar-o sidebar-dark enable-page-overlay side-scroll page-header-fixed main-content-narrow remember-theme">
      <!-- SIDEBAR FRAGMENT -->
      <jsp:include page="./fragments/sidebar.fragment.jsp"/>
      <!-- HEADER FRAGMENT -->
      <jsp:include page="./fragments/header.fragment.jsp"/>
  <main id="main-container">
<div class="bg-image" style="background-image: url('./public/admin/media/photos/photo12@2x.jpg');">
  <div class="bg-black-50">
    <div class="content content-full text-center">
      <div class="my-3">
        <img class="img-avatar img-avatar-thumb" src="${AuthUser.avatar.length() > 0 ? AuthUser.avatar : './public/admin/media/avatars/avatar13.jpg' }" alt="">
      </div>
      <h1 class="h2 text-white mb-0">${AuthUser.firstname } ${AuthUser.lastname }</h1>
      <span class="text-white-75">${AuthUser.account_type }</span>
    </div>
  </div>
</div>
<div class="bg-body-extra-light">
  <div class="content content-boxed">
    <div class="row items-push text-center">
      <div class="col-6 col-md-4">
        <div class="fs-sm fw-semibold text-muted text-uppercase">Số bài viết</div>
        <a class="link-fx fs-3" href="javascript:void(0)">${ postSummary }</a>
      </div>
      <div class="col-6 col-md-4">
        <div class="fs-sm fw-semibold text-muted text-uppercase">Số lượt xem</div>
        <a class="link-fx fs-3" href="javascript:void(0)">${AuthUser.viewer }</a>
      </div>
      <div class="col-6 col-md-4">
        <div class="fs-sm fw-semibold text-muted text-uppercase">Số bình luận</div>
        <a class="link-fx fs-3" href="javascript:void(0)">${ commentSummary }</a>
      </div>
    </div>
  </div>
</div>
<div class="content">
  <div class="row">
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
    <div class="col-md-7 col-xl-5">
      <div class="block block-rounded">
        <div class="block-header block-header-default">
          <h3 class="block-title">
            <i class="fa fa-briefcase text-muted me-1"></i> Thông Tin Cá Nhân
          </h3>
        </div>
        <div class="block-content">
         	<form class="js-validation" action="${ ADMINURL }/profile_info.htm" method="POST">
	           <div class="mb-4">
	              <label class="form-label" for="text">Họ</label>
	              <input type="text" class="form-control" id="firstname" name="firstname" placeholder="Họ" required="required" value="${ user.firstname }" >
	            </div>
	            <div class="mb-4">
	              <label class="form-label" for="lastname">Tên</label>
	               <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Tên" required="required"  value="${ user.lastname }" >
	            </div>
	            <div class="mb-4">
	              <label class="form-label" for="bio">Bio</label>
	              <textarea  class="form-control" id="bio" name="bio" rows="7" placeholder="Nhập bio" >${ user.bio }</textarea>
	            </div>
	            <div class="mb-4">
	            <label class="form-label" for="avatar">Avatar</label>
	            	<div class="input-group">
			             <input class="form-control" id="avatar" name="avatar" placeholder="Nhập avatar" value="${ user.avatar }">
			            <span class="input-group-append">
							<button type="button" class="btn btn-primary avatar"><i class="fas fa-image"></i></button>
						  </span>
						</div>
						
	              
	              
	            </div>
	            <div class="mb-4">
	              <label class="form-label" for="example-email-input">Email</label>
	               <input type="email" class="form-control" id="email" name="email" disabled="disabled" value="${ user.email }" placeholder="Email" required="required" >
	            </div>
	            <div class="row mb-4">
                  <div class="col-md-6 col-xl-5">
                    <button type="submit" class="btn w-100 btn-primary">
                      Lưu
                    </button>
                  </div>
                </div>
           	</form>
        </div>
      </div>
    </div>
     <div class="col-md-7 col-xl-4">
      <div class="block block-rounded">
        <div class="block-header block-header-default">
          <h3 class="block-title">
            <i class="fa fa-briefcase text-muted me-1"></i> Thay Đổi Mật Khẩu
          </h3>
        </div>
        <div class="block-content">
          <form class="js-validation-password" action="${ ADMINURL }/profile_password.htm" method="POST">
	           <div class="mb-4">
	              <label class="form-label" for="curent_pass">Mật khẩu hiện tại</label>
	              <input type="password" class="form-control" id="password_current" name="password_current" placeholder="Mật khẩu hiện tại" required="required" >
	            </div>
	            <div class="mb-4">
	              <label class="form-label" for="password_new">Mật khẩu mới</label>
	               <input type="password" class="form-control" id="password_new" name="password_new" placeholder="Mật khẩu mới" required="required" >
	            </div>
	            
	            <div class="mb-4">
	              <label class="form-label" for="password_confirm">Nhập lại mật khẩu mới</label>
	               <input type="password" class="form-control" id="password_confirm" name="password_confirm" placeholder="Nhập lại mật khẩu mới" required="required"  >
	            </div>
	            

	            <div class="row mb-4">
                  <div class="col-md-6 col-xl-5">
                    <button type="submit" class="btn w-100 btn-primary">
                      Đổi mật khẩu
                    </button>
                  </div>
                </div>
           	</form>
        </div>
      </div>
    </div>
    <div class="col-md-5 col-xl-3">
      <div class="block block-rounded">
        <div class="block-header block-header-default">
          <h3 class="block-title">
            <i class="fa fa-briefcase text-muted me-1"></i> Mạng xã hội
          </h3>
        </div>
        <div class="block-content">
          <form class="js-validation-social" action="${ ADMINURL }/profile_social.htm" method="POST">
	           <div class="mb-4">
	              <label class="form-label" for="facebook">Facebook</label>
	              <input type="text" class="form-control" id="facebook" name="facebook" placeholder="Facebook" required="required" value="${ UserSettings.facebook }" >
	            </div>
	            <div class="mb-4">
	              <label class="form-label" for="pinterest">Pinterest</label>
	               <input type="text" class="form-control" id="pinterest" name="pinterest" placeholder="Pinterest" required="required"  value="${ UserSettings.pinterest }" >
	            </div>
	            
	            <div class="mb-4">
	              <label class="form-label" for="tumblr">Tumblr</label>
	               <input type="text" class="form-control" id="tumblr" name="tumblr" placeholder="Tumblr" required="required"  value="${ UserSettings.tumblr }" >
	            </div>
	            
	            <div class="mb-4">
	              <label class="form-label" for="vkontakte">Vkontakte</label>
	               <input type="text" class="form-control" id="vkontakte" name="vkontakte" placeholder="Vkontakte" required="required"  value="${ UserSettings.vkontakte }" >
	            </div>
	            
	            <div class="mb-4">
	              <label class="form-label" for="whatsapp">Whatsapp</label>
	               <input type="text" class="form-control" id="whatsapp" name="whatsapp" placeholder="Whatsapp" required="required"  value="${ UserSettings.whatsapp }" >
	            </div>
	            
	            <div class="mb-4">
	              <label class="form-label" for="telegram">Telegram</label>
	               <input type="text" class="form-control" id="telegram" name="telegram" placeholder="Telegram" required="required"  value="${ UserSettings.telegram }" >
	            </div>

	            <div class="row mb-4">
                  <div class="col-md-6 col-xl-5">
                    <button type="submit" class="btn w-100 btn-primary">
                      Lưu
                    </button>
                  </div>
                </div>
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
		<script src="./public/admin/js/oneui.app.min.js"></script>
		<script src="./public/admin/js/lib/jquery.min.js"></script>
		<script src="./public/admin/js/plugins/jquery-validation/jquery.validate.min.js"></script>
		<script src="./public/vendor/ckfinder/ckfinder.js"></script>
		<script src="./public/admin/js/pages/profile.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
		<script>
		
			$("body").on("click", ".avatar", function(){
				CKFinder.popup( {
					basePath: "${APPURL}/public/vendor/ckfinder/",
					height: 700,
					selectActionFunction: function( fileUrl ) {
						$("#avatar").val(fileUrl)
		            }
				});
			});
			
		
		</script>
  </body>
</html>