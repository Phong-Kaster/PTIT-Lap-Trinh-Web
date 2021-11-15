<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Widget - ${ SettingsData.getSite_name() }</title>
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
<div id="page-container" class="sidebar-o sidebar-dark enable-page-overlay side-scroll page-header-fixed main-content-narrow remember-theme">
      <!-- SIDEBAR FRAGMENT -->
      <jsp:include page="./fragments/sidebar.fragment.jsp"/>
      <!-- HEADER FRAGMENT -->
      <jsp:include page="./fragments/header.fragment.jsp"/>
  <main id="main-container">
<div class="content">
<div class="row">
	<div class="col-xl-4">
		<div class="block block-rounded">
		    <div class="block-header block-header-default">
		      <h3 class="block-title">Thêm widget</h3>
		    </div>
		    <div class="block-content">
			    <form class="widget-form" action="${ ADMINURL }/widget.htm" method="post">
				   <input type="hidden" name="order_widget" value="${ listWidget.size() + 1 }">
				   <div class="mb-4">
				      <label for="title" class="form-label">Tiêu Đề</label>
				      <input type="text" class="form-control" name="title" placeholder="Tiêu Đề">
				   </div>
				   <div class="mb-4">
				      <label for="num_post" class="form-label">Số lượng bài hiện thị</label>
				      <input type="number" class="form-control" name="num_post" placeholder="Số lượng bài hiện thị">
				   </div>
				   <div class="mb-4">
				      <label for="layout" class="form-label">Layout</label>
				      <select class="form-select" id="layout" name="layout">
				         <option value="layout-group-1">Layout Group 1</option>
				         <option value="layout-group-2">Layout Group 2</option>
				         <option value="layout-group-3">Layout Group 3</option>
				         <option value="layout-group-4">Layout Group 4</option>
				         <option value="layout-grid-1">Layout Grid 1</option>
				         <option value="layout-grid-2">Layout Grid 2</option>
				         <option value="layout-vertical">Layout Vertical</option>
				      </select>
				   </div>
				   <div class="mb-4">
				      <label for="cat_id" class="form-label">Chuyên Mục</label>
				      <select class="form-control" id="cat_id" name="cat_id">
				         <c:forEach var="c" items="${ listCategories }">
				         	<option value="${ c.category.id }">${ c.category.name }</option>
					          	<c:if test = "${c.children != null && c.children.size() > 0}">
					              <c:forEach var="child" items="${c.children}">
									  <option value="${ child.id }">&nbsp;&nbsp;&nbsp;--${ child.name }</option>
					                </c:forEach>
							  	</c:if>
                			</c:forEach>
				      </select>
				   </div>
				   <div class="row mb-4">
                  <div class="col-md-6 col-xl-5">
                    <button type="submit" class="btn w-100 btn-primary">
                      Thêm widget
                    </button>
                  </div>
                </div>
				</form>
		    </div>
		  </div>
	</div>
	<div class="col-xl-6">
	 <form class="js-ajax-form" action="${ ADMINURL }/widget-update.htm" method="post">
		<div id="items">
			     <c:forEach var="widget" items="${ listWidget }">
			     <input type="hidden" name="id[]" value="${widget.id }">
					<div class="block block-rounded block-themed block-mode-hidden mb-2"  id="widget_${widget.id }">
				        <div class="block-header bg-muted">
				          <h3 class="block-title">${ widget.title }</h3>
				          <div class="block-options">
				            
				            <button type="button" class="btn btn-sm btn-alt-secondary" data-toggle="block-option" data-action="content_toggle">
				            	<i class="si si-arrow-up"></i>
				            </button>
				            <button type="button" class="btn btn-sm btn-alt-danger remove-widget" data-action="close" data-id="${ widget.id }" data-url="${ADMINURL }/widget.htm">
				              <i class="si si-close"></i>
				            </button>
				            
				          </div>
				        </div>
				        <div class="block-content">
						   <div class="mb-4">
						      <label for="title" class="form-label">Tiêu Đề</label>
						      <input type="text" class="form-control" name="title[]" placeholder="Tiêu Đề" value="${ widget.title }">
						   </div>
						   <div class="mb-4">
						      <label for="num_post" class="form-label">Số lượng bài hiện thị</label>
						      <input type="number" class="form-control" name="num_post[]" value="${ widget.num_post }" placeholder="Số lượng bài hiện thị">
						   </div>
						   <div class="mb-4">
						      <label for="layout" class="form-label">Layout</label>
						      <select class="form-select" id="layout" name="layout[]">
						         <option value="layout-group-1" ${ widget.layout == 'layout-group-1' ? 'selected' : '' }>Layout Group 1</option>
						         <option value="layout-group-2" ${ widget.layout == 'layout-group-2' ? 'selected' : '' }>Layout Group 2</option>
						         <option value="layout-group-3" ${ widget.layout == 'layout-group-3' ? 'selected' : '' }>Layout Group 3</option>
						         <option value="layout-group-4" ${ widget.layout == 'layout-group-4' ? 'selected' : '' }>Layout Group 4</option>
						         <option value="layout-grid-1" ${ widget.layout == 'layout-grid-1' ? 'selected' : '' }>Layout Grid 1</option>
						         <option value="layout-grid-2" ${ widget.layout == 'layout-grid-2' ? 'selected' : '' }>Layout Grid 2</option>
						         <option value="layout-vertical" ${ widget.layout == 'layout-vertical' ? 'selected' : '' }>Layout Vertical</option>
						      </select>
						   </div>
						   <div class="mb-4">
						      <label for="cat_id" class="form-label">Chuyên Mục</label>
						      <select class="form-control" id="cat_id" name="cat_id[]">
						         <c:forEach var="c" items="${ listCategories }">
					         		<option value="${ c.category.id }" ${ widget.category.id ==  c.category.id ? 'selected' : ''}>${ c.category.name }</option>
						          	<c:if test = "${c.children != null && c.children.size() > 0}">
						              <c:forEach var="child" items="${c.children}">
										  <option value="${ child.id }" ${ widget.category.id ==  child.id ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;--${ child.name }</option>
						                </c:forEach>
								  	</c:if>
	                			</c:forEach>
						      </select>
						   </div>
				       </div>
				     </div>
				  </c:forEach>
				 
				    
				</div>
				 <button type="submit" class="btn w-100 btn-primary mt-4">
                      Lưu vị trí
                    </button>
				</form>
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
		<script src="./public/admin/js/plugins/sortablejs/sortable.min.js"></script>
		<script src="./public/admin/js/plugins/sweetalert2/sweetalert2.min.js"></script>
		<script src="./public/admin/js/lib/jquery.min.js"></script>
		<script src="./public/admin/js/plugins/jquery-validation/jquery.validate.min.js"></script>
		<script src="./public/admin/js/pages/widget.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
		<script>
			var el = document.getElementById('items');
			var sortable = Sortable.create(el, { animation: 150 });

		
		</script>
  </body>
</html>