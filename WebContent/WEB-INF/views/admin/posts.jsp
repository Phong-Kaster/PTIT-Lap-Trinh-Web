<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Bài viết - ${ SettingsData.getSite_name() }</title>
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
	<div class="sub mb-3 fs-sm">
		<c:forEach items="${listSummary}" var="summary">
			<c:if test="${ summary[0] == 'publish' }">
			  		<c:choose>
					    <c:when test="${ param.post_status == null || param.post_status == 'publish' }">
					    	<a class=" link-fx text-primary-darker" href="${ ADMINURL }/posts.htm?post_status=publish">
					    		<strong>Xuất bản (${ summary[1] })</strong>
					  		</a>
					    </c:when>    
					    <c:otherwise>
					    	<a class=" link-fx" href="${ ADMINURL }/posts.htm?post_status=publish">
					    		 Xuất bản (${ summary[1] })
					  		</a>
					    </c:otherwise>
					</c:choose>
	            |
            </c:if>
        </c:forEach>
        
        <c:forEach items="${listSummary}" var="summary">
			<c:if test="${ summary[0] == 'draft' }">
			  		<c:choose>
					    <c:when test="${ param.post_status == 'draft' }">
					    	<a class=" link-fx text-primary-darker" href="${ ADMINURL }/posts.htm?post_status=draft">
					    		<strong>Nháp (${ summary[1] })</strong>
					  		</a>
					    </c:when>    
					    <c:otherwise>
					    	<a class=" link-fx" href="${ ADMINURL }/posts.htm?post_status=draft">
					    		 Nháp (${ summary[1] })
					  		</a>
					    </c:otherwise>
					</c:choose>
	            |
            </c:if>
        </c:forEach>
        
        <c:forEach items="${listSummary}" var="summary">
			<c:if test="${ summary[0] == 'pending' }">
			  		<c:choose>
					    <c:when test="${ param.post_status == 'pending' }">
					    	<a class=" link-fx text-primary-darker" href="${ ADMINURL }/posts.htm?post_status=pending">
					    		<strong>Chờ duyệt (${ summary[1] })</strong>
					  		</a>
					    </c:when>    
					    <c:otherwise>
					    	<a class=" link-fx" href="${ ADMINURL }/posts.htm?post_status=pending">
					    		 Chờ duyệt (${ summary[1] })
					  		</a>
					    </c:otherwise>
					</c:choose>
	            |
            </c:if>
        </c:forEach>
        
        <c:forEach items="${listSummary}" var="summary">
			<c:if test="${ summary[0] == 'trash' }">
			  		<c:choose>
					    <c:when test="${ param.post_status == 'trash' }">
					    	<a class=" link-fx text-primary-darker" href="${ ADMINURL }/posts.htm?post_status=trash">
					    		<strong>Rác (${ summary[1] })</strong>
					  		</a>
					    </c:when>    
					    <c:otherwise>
					    	<a class=" link-fx" href="${ ADMINURL }/posts.htm?post_status=trash">
					    		 Rác (${ summary[1] })
					  		</a>
					    </c:otherwise>
					</c:choose>
            </c:if>
        </c:forEach>
  	
  	</div>
  <div class="block block-rounded">
    <div class="block-header block-header-default">
      
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group">
		          <select class="form-select form-select-sm" id="action" name="action" style="width: 120px">
		          	<option value="-1">Chọn hành động</option>
		          	<c:choose>
					    <c:when test="${ param.post_status == 'trash' }">
					    	<option value="restore">Khôi phục</option>
					    	<option value="delete">Xóa vĩnh viễn</option>
					    </c:when>    
					    <c:otherwise>
					    	<option value="trash">Cho vào rác</option>
					    </c:otherwise>
					</c:choose>
		          	
		         </select>
		        </div>
			</div>
			<div class="col-sm-6">
				<button class="btn btn-sm btn-primary btn-action" data-url="${ADMINURL }/post_bulk.htm" >Thực hiện</button>
			</div>
		</div>
      <div class="block-options">
        <button type="button" class="btn btn-sm btn-alt-secondary" data-toggle="class-toggle" data-target="#one-search" data-class="d-none">
          <i class="fa fa-search"></i>
        </button>
      </div>
    </div>
    <div id="one-search" class="block-content border-bottom d-none">
      <form action="${ADMINURL }/posts.htm" method="GET">
        <div class="push">
          <div class="input-group">
            <input type="text" class="form-control form-control-alt" id="search" value="${ param.search }" name="search" placeholder="Tìm bài viết">
            <span class="input-group-text bg-body border-0">
              <i class="fa fa-search"></i>
            </span>
          </div>
        </div>
      </form>
    </div>
    <div class="block-content">
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
      <table class="table table-striped table-borderless table-vcenter">
        <thead class="border-bottom">
          <tr>
          	<th class="d-none d-md-table-cell text-center" style="width: 50px;">
          		<div class="form-check">
                  <input class="form-check-input" type="checkbox" id="check-all" name="check-all">
                </div>
             </th>
            <th colspan="2">Tiêu đề</th>
            <th class="d-none d-md-table-cell text-center" style="width: 100px;">Tác giả</th>
            <th class="d-none d-md-table-cell text-center" style="width: 100px;">Thể Loại</th>
            <th class="d-none d-md-table-cell" style="width: 200px;">Ngày</th>
            <th class="d-none d-md-table-cell" >Nổi bật</th>
            <th class="d-none d-md-table-cell">Hành động</th>
          </tr>
        </thead>
        <tfoot class="border-bottom">
          <tr>
          	<th class="d-none d-md-table-cell text-center" style="width: 50px;">
          		<div class="form-check">
                  <input class="form-check-input" type="checkbox" id="check-all" name="check-all">
                </div>
             </th>
            <th colspan="2">Tiêu đề</th>
            <th class="d-none d-md-table-cell text-center" style="width: 100px;">Tác giả</th>
            <th class="d-none d-md-table-cell text-center" style="width: 100px;">Thể Loại</th>
            <th class="d-none d-md-table-cell" style="width: 200px;">Ngày</th>
            <th class="d-none d-md-table-cell" >Nổi bật</th>
            <th class="d-none d-md-table-cell">Hành động</th>
          </tr>
        </tfoot>
        <tbody>
        	<jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder"/>
			<c:url value="${ ADMINURL }/posts.htm?search=${ param.search }&user_id=${ param.user_id }&cat_id=${ param.cat_id }&post_status=${ param.post_status != null ? param.post_status : 'publish' }" var="pagedLink">
				<c:param name="p" value="~" />
			</c:url>
			<c:forEach var="post" items="${ pagedListHolder.pageList }" begin="0" > 			
	          <tr>
	            <td class="text-center" style="width: 40px;">
	              <div class="form-check">
	                  <input class="form-check-input" type="checkbox" value="${ post.id }" id="items[]" name="items[]">
	                </div>
	            </td>
	            <td colspan="2">
	            	<c:choose>
					    <c:when test="${ post.post_status == 'trash' }">
					    	<span class="fw-semibold">${ post.title }</span>
					    </c:when>    
					    <c:otherwise>
					        <a class="fw-semibold" href="${ ADMINURL }/post.htm?postid=${ post.id }">${ post.title }</a>
					    </c:otherwise>
					</c:choose>
	            </td>
	            <td class="d-none d-md-table-cell text-center">
					<a class="fw-semibold" href="${ADMINURL }/posts.htm?user_id=${ post.user.id }">${ post.user.username }</a>
	            </td>
	            <td class="d-none d-md-table-cell text-center">
	              <a class="fw-semibold" href="${ADMINURL }/posts.htm?cat_id=${ post.category.id }">${ post.category.name }</a>
	            </td>
	            <td class="d-none d-md-table-cell">
	              <span class="fs-sm"> ${ post.post_status } <br> ${ dateFormatPost.format(post.modified_at) }</span>
	            </td>
	            <td class="d-none d-md-table-cell">
	            	<c:choose>
					    <c:when test="${ post.featured == 'true' }">
					    	<a class="btn-featured" href="javascript:void(0)" data-url="${ADMINURL }/post_featured.htm" data-id="${ post.id }">
			            		<i class="fa fa-star text-warning"></i>
			            	</a>
					    </c:when>    
					    <c:otherwise>
					        <a class="btn-featured" href="javascript:void(0)"  data-url="${ADMINURL }/post_featured.htm" data-id="${ post.id }">
			            		<i class="far fa-star"></i>
			            	</a>
					    </c:otherwise>
					</c:choose>
	            </td>
	            <td class="text-center">
                  <a class="btn btn-sm btn-alt-secondary" href="${APPURL }/article/${post.id}/${post.post_slug}.htm" target="_blank" data-bs-toggle="tooltip" title="View">
                    <i class="fa fa-fw fa-eye"></i>
                  </a>
                  
                  <a class="btn btn-sm btn-alt-secondary" href="${ADMINURL }/${ post.post_status == 'trash' ? 'post_delete' : 'post_trash' }.htm?postid=${post.id}&next=${dataUrl}" data-bs-toggle="tooltip" title="Delete">
                    <i class="fa fa-fw fa-times"></i>
                  </a>
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
		<script src="./public/admin/js/pages/post.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
		<script>
			$( document ).ready(function() {
				
				TimesWriter.CheckAll();
				TimesWriter.Featured();
				TimesWriter.ActionSubmit();
				
			});
		</script>
  </body>
</html>