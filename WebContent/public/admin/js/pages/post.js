function ChangeToSlug(title){
	var slug;
    //Lấy text từ thẻ input title 
 
    //Đổi chữ hoa thành chữ thường
    slug = title.toLowerCase();
 
    //Đổi ký tự có dấu thành không dấu
    slug = slug.replace(/á|à|ả|ạ|ã|ă|ắ|ằ|ẳ|ẵ|ặ|â|ấ|ầ|ẩ|ẫ|ậ/gi, 'a');
    slug = slug.replace(/é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ/gi, 'e');
    slug = slug.replace(/i|í|ì|ỉ|ĩ|ị/gi, 'i');
    slug = slug.replace(/ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ/gi, 'o');
    slug = slug.replace(/ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự/gi, 'u');
    slug = slug.replace(/ý|ỳ|ỷ|ỹ|ỵ/gi, 'y');
    slug = slug.replace(/đ/gi, 'd');
    //Xóa các ký tự đặt biệt
    slug = slug.replace(/\`|\~|\!|\@|\#|\||\$|\%|\^|\&|\*|\(|\)|\+|\=|\,|\.|\/|\?|\>|\<|\'|\"|\:|\;|_/gi, '');
    //Đổi khoảng trắng thành ký tự gạch ngang
    slug = slug.replace(/ /gi, "-");
    //Đổi nhiều ký tự gạch ngang liên tiếp thành 1 ký tự gạch ngang
    //Phòng trường hợp người nhập vào quá nhiều ký tự trắng
    slug = slug.replace(/\-\-\-\-\-/gi, '-');
    slug = slug.replace(/\-\-\-\-/gi, '-');
    slug = slug.replace(/\-\-\-/gi, '-');
    slug = slug.replace(/\-\-/gi, '-');
    //Xóa các ký tự gạch ngang ở đầu và cuối
    slug = '@' + slug + '@';
    slug = slug.replace(/\@\-|\-\@|\@/gi, '');
    return slug;
}

var TimesWriter = {};

TimesWriter.CheckAll = function(){
    $("body").on("click", "#check-all", function(){
        var isCheck = $(this).is(":checked");
        document.getElementsByName('items[]').forEach(item => item.checked = isCheck);
    });
}


TimesWriter.Thumbnail = function(){
	$(".btn-add-thumbnail").on("click",function(){
		CKFinder.popup( {
			basePath: "${APPURL}/public/vendor/ckfinder/",
			height: 700,
			selectActionFunction: function( fileUrl ) {
                 $("#media").val(fileUrl);
                 $("#noMedia").css("display", "none");
                 $("#hasMedia").css("display", "block");
                 $("#hasMedia > img").attr("src", fileUrl);
            }
		});
    })
    
    $(".btn-delete-thumbnail").on("click",function(){
        $("#noMedia").css("display", "block");
        $("#hasMedia").css("display", "none");
        $("#hasMedia > img").attr("src", "");
        $("#media").val(fileUrl);
    })
}

TimesWriter.SlugUrl = function(){
    $("body").on("input propertychange keyup", ".slug_title", function(){
        var slug_title = $(this).val();
        var slug_url = $(".slug_url");
        slug_url.val(ChangeToSlug(slug_title));
    });
}

TimesWriter.Featured = function () {
    $(".btn-featured").on("click", function() {
        var $this = $(this);
        $form = $this.parents(".block ");
        $form.addClass('block-mode-loading');
        var url = $this.data("url");
        var id = $this.data("id");

        $.ajax({
            url: url,
            type: 'POST',
            data: {
                action: 'featured',
                id: id,
            },
            error: function(error) {
                $form.removeClass('block-mode-loading');
                Swal.fire('Oops...', "Oops! Đã xảy ra lỗi. Vui lòng thử lại sau!", 'error')
            },

            success: function(resp) {
            	$form.removeClass('block-mode-loading');
            	if(resp.result == 0){
                    Swal.fire('Oops...', resp.msg, 'error')
                }else{
                   $this.html(resp.html);
                }
            }
        });
    });
 }

TimesWriter.ActionSubmit = function () {
    $(".btn-action").on("click", function() {
        var $this = $(this);
        $form = $this.parents(".block ");
        
        var ids = [];
        document.querySelectorAll('input[name="items[]"]:checked').forEach(item => ids.push(item.value));
        ids = ids.filter(Boolean);
        if(ids.length == 0){
            Swal.fire('Oops...', "Vui lòng chọn ít nhất một bài viết", 'error');
            return;
        }
        
        
        var url = $this.data("url");
        var action = $("#action").val();
        if(action == "-1" || action == null){
        	Swal.fire('Oops...', "Hãy chọn hành động thực hiện", 'error');
            return;
        }
        $form.addClass('block-mode-loading');
        $.ajax({
            url: url,
            type: 'POST',
            data: {
                action: action,
                ids: ids,
                next: window.location.href,
            },
            error: function(error) {
                $form.removeClass('block-mode-loading');
                Swal.fire('Oops...', "Oops! Đã xảy ra lỗi. Vui lòng thử lại sau!", 'error')
            },

            success: function(resp) {
            	$form.removeClass('block-mode-loading');
        		if(resp.result == 0){
                    Swal.fire('Oops...', resp.msg, 'error')
                }else{
                	window.location.href = window.location.href;
                }
            }
        });
    });
 }

TimesWriter.Validate = function () {
	$(".post-form").on('submit',function (e){
		$form = $(this);
		var title = $form.find("input[name=title]").val(),
			post_slug = $form.find("input[name=title]").val(),
			content = $form.find("textarea[name=content]").val(),
			post_status = $form.find("select[name=post_status]").val(),
			comment_status = $form.find("select[name=comment_status]").val(),
			media = $form.find("input[name=media]").val();
		
		if(!title){
			Swal.fire('Oops...', "Tiêu đề không được bỏ trống!", 'warning');
			e.preventDefault();
			return false;
		}
		if(!post_slug){
			Swal.fire('Oops...', "Slug bài viết không được bỏ trống!", 'warning');
			e.preventDefault();
			return false;
		}
		if(!content){
			Swal.fire('Oops...', "Nội dung bài viết không được bỏ trống!", 'warning');
			e.preventDefault();
			return false;
		}
		if(!post_status){
			Swal.fire('Oops...', "Trạng thái bài viết không được bỏ trống!", 'warning');
			e.preventDefault();
			return false;
		}
		if(!comment_status){
			Swal.fire('Oops...', "Trạng thái bình luận không được bỏ trống!", 'warning');
			e.preventDefault();
			return false;
		}
		if(!media){
			Swal.fire('Oops...', "Ảnh bài không được bỏ trống!", 'warning');
			e.preventDefault();
			return false;
		}
		return true;
	});
 }

