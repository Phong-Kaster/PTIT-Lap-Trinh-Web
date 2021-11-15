<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <script>
         (function($){
            $("body").on("submit", ".mc4wp-form", function(){
               $form = $(this);
               $form.find(".mc4wp-success").html("<p>Đang thực hiện....</p>");
               $form.find("input#submit").prop('disabled', true);
               $.ajax({
                  url: $form.attr("action"),
                  type: $form.attr("method"),
                  dataType: 'json',
                  data: $form.serialize(),
                  error: function() {
                     $form.find("input#submit").prop('disabled', false);
                     $form.find(".mc4wp-success").html("<p>Oops! Đã xảy ra lỗi. Vui lòng thử lại sau!</p>");
                  },
                  success: function(resp) {
                     if (typeof resp.redirect === "string") {
                           window.location.href = resp.redirect;
                     } else if (typeof resp.msg === "string") {
                           $form.find("input#submit").prop('disabled', false);
                           $form.find(".mc4wp-success").html(resp.msg);
                     } else {
                           $form.find("input#submit").prop('disabled', false);
                           $form.find(".mc4wp-success").html("<p>Oops! Đã xảy ra lỗi. Vui lòng thử lại sau!</p>");
                     }
                  }
               });
               return false;
            })
         })(jQuery);
      </script>