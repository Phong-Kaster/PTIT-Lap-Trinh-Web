/*!
 * oneui - v5.1.0
 * @author pixelcave - https://pixelcave.com
 * Copyright (c) 2021
 */
One.onLoad(class {
    static initValidation() {
        One.helpers("jq-validation"), jQuery(".js-validation").validate({
            rules: {
                "firstname": {
                    required: !0,
                    minlength: 3
                },
                "lastname": {
                    required: !0,
                    minlength: 3
                }
            },
            messages: {
                "firstname": {
                    required: "Hãy nhập họ",
                    minlength: "Họ phải chứa ít nhất 3 chữ"
                },
                "lastname": {
                    required: "Hãy nhập tên",
                    minlength: "Tên phải chứa ít nhất 3 chữ"
                }
            }
        }), jQuery(".js-validation-password").validate({
            rules: {
                "password_current": {
                    required: !0,
                    minlength: 6
                },
                "password_new": {
                    required: !0,
                    minlength: 6
                },
                "password_confirm": {
                    required: !0,
                    minlength: 6,
                    equalTo: "#password_new"
                }
            },
            messages: {
                "password_current": {
                    required: "Hãy nhập mật khẩu hiện tại",
                    minlength: "Mật khẩu phải chứa ít nhất 6 chữ"
                },
                "password_new": {
                    required: "Hãy nhập mật khẩu mới",
                    minlength: "Mật khẩu phải chứa ít nhất 6 chữ"
                },
                "password_confirm": {
                    required: "Hãy nhập lại mật khẩu mới",
                    minlength: "Mật khẩu phải chứa ít nhất 6 chữ",
                    equalTo: "Không trùng với mật khẩu mới"
                }
            }
        })
    }
    static init() {
        this.initValidation()
    }
}.init());