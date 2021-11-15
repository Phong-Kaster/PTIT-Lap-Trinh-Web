/*!
 * oneui - v5.1.0
 * @author pixelcave - https://pixelcave.com
 * Copyright (c) 2021
 */
One.onLoad(class {
    static activeMenu() {
    	// get last string in pathname
        var url = window.location.pathname;
        var urlArray = url.split("/");
        var id = urlArray[urlArray.length - 1].replace(".htm", "");
        
        // remove id if have
        if(id.includes("-")){
        	urlArray = id.split("-");
        	var last = urlArray[urlArray.length - 1];
        	if(/^[0-9]+$/.test(last)){
        		urlArray.pop();
        	}
        	id = urlArray.join("-");
        }
        
        var elm = jQuery("." + id);
        var parent_elm = elm.parents(".nav-main-item").last();
        if(!elm.hasClass("active")){
        	elm.addClass("active");
        	if(parent_elm && !parent_elm.hasClass("open")){
        		parent_elm.addClass("open");
        	}
        }
    }
    static init() {
        this.activeMenu()
    }
}.init());