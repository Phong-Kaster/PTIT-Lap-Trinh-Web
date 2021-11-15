<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> ${post.title == null ? 'Thêm bài viết mới' : 'Sửa bài viết' } - ${ SettingsData.getSite_name() }</title>
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
	          Bài viết
	        </h1>
	      </div>
	     <a  href="${ ADMINURL }/post.htm" class="btn btn-sm btn-primary">
	                <i class="fa fa-plus me-1"></i> Bài viết mới
	              </a>
	    </div>
	  </div>
	</div>
	<div class="content">
		<form class="mb-4 post-form" action="${ADMINURL }/post.htm?postid=${ post.id }" method="POST">
			<c:if test="${successMessage != null && successMessage.trim().length() > 0 }">
				<div class="alert alert-success alert-dismissible" role="alert">
		            <p class="mb-0">
		              ${ successMessage } <a class="alert-link" target="_blank" href="${APPURL }/article/${ post.id }/${ post.post_slug }.htm">Xem bài viết</a>!
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
		
	 		<div class="row">
		 		<div class="col-xl-9">
			 		<div class="mb-4">
		              <input type="text" class="form-control slug_title" id="title" value="${ post.title }" name="title" placeholder="Thêm tiêu đề">
		              <div class="row mt-2">
			              <label class="col-sm-1 fs-sm" for="post_slug">Liên kết: </label>
			              <div class="col-sm-9">
		              	 	<input type="text" class="form-control form-control-sm slug_url" id="post_slug" value="${ post.post_slug }" name="post_slug" placeholder="thu-tuong-chinh-phu">
			              </div>
			              <c:if test="${ post.id > 0 }">
			               	<a class="col-sm-1 btn btn-warning btn-sm" href="${APPURL }/article/${post.id}/${post.post_slug}.htm" target="_blank">Truy cập</a>
			              </c:if>
			            </div>
		            </div>
		            <textarea id="content" class="form-control" name="content" rows="50" cols="">${ post.content }</textarea>
		            <div class="form-group mt-4">
		            	<label class="form-label" for="excerpt">Nội dung trích đoạn</label>
		            	<textarea id="excerpt" class="form-control" name="excerpt" rows="7" cols="">${ post.excerpt }</textarea>
		            </div>
		 		</div>
		 		<div class="col-xl-3">
		 			<div class="block block-rounded block-bordered">
				        <div class="block-header block-header-default">
				          <h3 class="block-title">Xuất bản</h3>
				          <div class="block-options">
				            <button type="button" class="btn-block-option" data-toggle="block-option" data-action="content_toggle"></button>
				          </div>
				        </div>
				        <div class="block-content">
				         	<div class="mb-4">
				              <label class="form-label" for="post_status">Tình trạng bài viết</label>
				              <select class="form-select" id="post_status" name="post_status">
				                <option value="" disabled>Chọn tình trạng</option>
				                <option value="pending"  ${post.post_status == 'pending' ? 'selected' : ''}>Đang chờ duyệt</option>
				                <option value="publish"  ${post.post_status == 'publish' ? 'selected' : ''}>Đã xuất bản</option>
				                <option value="draft"  ${post.post_status == 'draft' ? 'selected' : ''}>Bản nháp</option>
				              </select>
				            </div>
				            <div class="mb-4">
				              <label class="form-label" for="comment_status">Tình trạng bình luận</label>
				              <select class="form-select" id="comment_status" name="comment_status">
				              	<option value="" disabled>Chọn tình trạng</option>
				                <option value="true"  ${post.comment_status == 'true' ? 'selected' : ''}>Cho phép</option>
				                <option value="false"  ${post.comment_status == 'false' ? 'selected' : ''}>Không cho phép</option>
				              </select>
				            </div>
				            <div class="row mb-4">
								<div class="col-9">
									<a href="${ADMINURL }/post_trash.htm?postid=${post.id}" class="fs-sm submitdelete" style="color: #b32d2e;text-decoration: underline;">Cho vào thùng rác</a>
								</div>
								<div class="col-2 text-right">
									<button type="submit" class="btn btn-primary">Lưu</button>
								</div>
							</div>
				         
				        </div>
			     	</div>
			     	
			     	
			     	<div class="block block-rounded block-bordered">
				        <div class="block-header block-header-default">
				          <h3 class="block-title">Thể Loại</h3>
				          <div class="block-options">
				            <button type="button" class="btn-block-option" data-toggle="block-option" data-action="content_toggle"></button>
				          </div>
				        </div>
				        
				        <div class="block-content">
				         	<div style="height: 300px; overflow: hidden scroll;" class="p-3">
				         		<c:forEach var="c" items="${ listCategories }">
						         	<div class="form-check"  style="margin-left: 0px">
					                  <input class="form-check-input" type="radio" ${ post.category.id ==  c.category.id ? 'checked' : ''} value="${ c.category.id }" id="cat_${ c.category.id }" name="cat_id">
					                  <label class="form-check-label" for="cat_${ c.category.id }">${ c.category.name }</label>
					                </div>
					                
					                <c:if test = "${c.children != null && c.children.size() > 0}">
					                	<c:forEach var="child" items="${c.children}">
									    	<div class="form-check"  style="margin-left: 20px">
							                  <input class="form-check-input" type="radio" ${ post.category.id ==  child.id ? 'checked' : ''} value="${ child.id }" id="cat_${ child.id }" name="cat_id">
							                  <label class="form-check-label" for="cat_${ child.id }">${ child.name }</label>
							                </div>
					                   </c:forEach>
							      	</c:if>
                				</c:forEach>
							</div>
				        </div>
				        
			     	</div>
			     	
			     	<div class="block block-rounded block-bordered">
				        <div class="block-header block-header-default">
				          <h3 class="block-title">Ảnh bìa</h3>
				          <div class="block-options">
				            <button type="button" class="btn-block-option" data-toggle="block-option" data-action="content_toggle"></button>
				          </div>
				        </div>
				        <div class="block-content">
					         <div id="hasMedia" style="${(post.media != '' && post.media != null) ? '' : 'display: none' }">
						         <input type="hidden" name="media" value="${ post.media }" id="media">
								<img src="${ post.media }" alt="Ảnh Thumbnail" class="img-fluid rounded btn-add-thumbnail">
								<p>Nhấn vào ảnh để sửa hoặc cập nhật</p>
								<a class="text-primary btn-delete-thumbnail" href="javascript:void(0)">
									<u>Xoá ảnh đại diện</u>
								</a>
							</div>
							<div id="noMedia" style="${(post.media != '' && post.media != null) ? 'display: none' : '' }">
								<a class="text-primary btn-add-thumbnail" href="javascript:void(0)">
									<u>Đặt ảnh đại diện</u>
								</a>
							</div>
				         
				        </div>
			     	</div>
		 		</div>
	 		</div>
	 	</form>
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
		<script src="./public/vendor/ckeditor/ckeditor.js"></script>
		<script src="./public/vendor/ckfinder/ckfinder.js"></script>
		<script src="./public/admin/js/pages/post.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
		<script>
			$( document ).ready(function() {
			    // khoi tao ckeditor va ckfinder
				var editor = CKEDITOR.replace('content');
				editor.config.height = '500px';
				CKFinder.setupCKEditor( editor, '${APPURL}/public/vendor/ckfinder/' );
				
				
				TimesWriter.Thumbnail();
				TimesWriter.SlugUrl();
				TimesWriter.Validate();
			    
				
			});
		</script>
		
  </body>
</html>