/*!
 * oneui - v5.1.0
 * @author pixelcave - https://pixelcave.com
 * Copyright (c) 2021
 */
One.onLoad(class {
    static initValidation() {
        One.helpers("jq-validation"), jQuery(".js-validation").validate({
            rules: {
                "password": {
                    minlength: 6
                },
                "password_confirm": {
                    minlength: 6,
                    equalTo: "#password_new"
                }
            },
            messages: {
                "password": {
                    minlength: "Mật khẩu phải chứa ít nhất 6 chữ"
                },
                "password_confirm": {
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