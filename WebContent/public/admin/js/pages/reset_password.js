/*!
 * oneui - v5.1.0
 * @author pixelcave - https://pixelcave.com
 * Copyright (c) 2021
 */
One.onLoad(class {
    static initValidation() {
        One.helpers("jq-validation"), jQuery(".js-validation-reset").validate({
            rules: {
                "password": {
                    required: !0,
                    minlength: 6
                },
                "repeatpassword": {
                    required: !0,
                    minlength: 6,
                    equalTo: "#password"
                }
            },
            messages: {
                "password": {
                    required: "Nhập mật khẩu",
                    minlength: "Mật khẩu phải có ít nhất 6 ký tự"
                },
                "repeatpassword": {
                    required: "Nhập mật khẩu",
                    minlength: "Mật khẩu phải có ít nhất 6 ký tự",
                    equalTo: "Mật khẩu xác nhận không trùng"
                }
            }
        })
    }
    static init() {
        this.initValidation()
    }
}.init());