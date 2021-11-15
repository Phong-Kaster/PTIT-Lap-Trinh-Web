/*!
 * oneui - v5.1.0
 * @author pixelcave - https://pixelcave.com
 * Copyright (c) 2021
 */
$( document ).ready(function() {
		
	$("body").on("click", ".remove-widget", function(){
		$button = $(this);
		var id = $button.data("id");
		var action = $button.data("action");
		var url = $button.data("url");
		$.ajax({
            url: url + "?id=" + id,
            type: 'PUT',
            error: function(error) {
                Swal.fire('Oops...', "Oops! Đã xảy ra lỗi. Vui lòng thử lại sau!", 'error')
            },

            success: function(resp) {
            	if(resp.result == 0){
                    Swal.fire('Oops...', resp.msg, 'error')
                }else{
                	One.block(action, "#widget_" + id);
                }
            }
        });
		
	})
	
	
	$("body").on("submit", ".js-ajax-form", function(){
		$form = $(this);
		var method = $form.attr("method");
		var action = $form.attr("action");
		$form.find("button[type='submit']").attr("disabled", true);
		$.ajax({
            url: action,
            type: method,
            data: $form.serialize(),
            error: function(error) {
                Swal.fire('Oops...', "Oops! Đã xảy ra lỗi. Vui lòng thử lại sau!", 'error');
                $form.find("button[type='submit']").attr("disabled", false);
            },

            success: function(resp) {
            	if(resp.result == 0){
                    Swal.fire('Oops...', resp.msg, 'error');
                }else{
                	Swal.fire('Thành công', resp.msg, 'success');
                }
                $form.find("button[type='submit']").attr("disabled", false);
            }
        });
		return false;
	})
				
});

One.onLoad(class {
    static initValidation() {
        One.helpers("jq-validation"), jQuery(".widget-form").validate({
            rules: {
                "title": {
                    required: !0,
                    minlength: 6
                },
                "layout": {
                    required: !0
                },
                "cat_id": {
                    required: !0
                },
                "num_post": {
                    required: !0
                }
            },
            messages: {
                "title": {
                    required: "Hãy nhập tiêu đề",
                    minlength: "Tiêu đều phải chứa ít nhất 6 chữ"
                },
                "layout": {
                    required: "Hãy chọn layout",
                },
                "cat_id": {
                    required: "Hãy chọn thể loại",
                },
                "num_post": {
                    required: "Hãy nhập số lượng hiện thị",
                }
            },
            submitHandler: function(form) {
            	var form = jQuery(form);
            	var parent = form.parent(".block");
        		parent.addClass('block-mode-loading');
        		
                var url = form.attr("url");
                jQuery.ajax({
                    url: url,
                    type: 'POST',
                    data: form.serialize(),
                    error: function(error) {
                    	parent.removeClass('block-mode-loading');
                        Swal.fire('Oops...', "Oops! Đã xảy ra lỗi. Vui lòng thử lại sau!", 'error')
                    },

                    success: function(resp) {
                    	parent.removeClass('block-mode-loading');
                    	if(resp.result == 0){
                            Swal.fire('Oops...', resp.msg, 'error')
                        }else{
                        	Swal.fire('Thành công', resp.msg, 'success');
                        	var listElem = jQuery("#items");
                        	listElem.append(resp.html);
                        	One._uiInit();
                        }
                    }
                });
            }
        })
    }
    static init() {
        this.initValidation();
    }
}.init());