(function($, WITHEMES) {
"use strict";
var WITHEMES = WITHEMES || {};
    
    if ( undefined == WITHEMES.tablet_breakpoint ) {
        WITHEMES.tablet_breakpoint = 840 // while iPad Pro 10" 834 inch
    }

/* Functions
--------------------------------------------------------------------------------------------- */
var isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};
    
/**
 * Debouce function
 *
 * @since 1.0
 */
window.debounce = function(func, wait, immediate) {
    var timeout;
    return function() {
        var context = this, args = arguments;
        var later = function() {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
};
    
/**
 * Fit Vids
 * @since 1.0
 */
WITHEMES.fitvids = function(){
    
    if ( $().fitVids ) {
        
        $( document, '.media-container' ).fitVids();
        
    }
    
}; // fitvids
    
/**
 * Tooltip
 * @since 4.0
 */
WITHEMES.tooltip = function() {

    if ( ! $().tooltipster ) {
        return;
    }

    var run = function() {

        var args = {
            theme: 'tooltipster-borderless',
            delay: 100,
            animation: 'fade',
            functionFormat: function( instance ) {
                return instance.content();
            }
        };

        // social list in widget
        $( '.widget .social-list a:not(.tooltipstered), .hastip' ).tooltipster( args );

        // share
        // args.theme = 'tooltipster-shadow';
        $( '.fox-share:not(.vshare) a:not(.tooltipstered)' ).tooltipster( args );
        
        args.side = 'right';
        $( '.fox-share.vshare a:not(.tooltipstered)' ).tooltipster( args );

        $( '.widget-author-grid .author-list-item-avatar a:not(.tooltipstered), .user-item-social a:not(.tooltipstered)' ).tooltipster({
            theme: 'tooltipster-borderless',
            delay: 100,
            animation: 'fade',
        });

    }

    if ( window.matchMedia( '(min-width:940px)' ).matches ) {
        run();
    }
}
    
/**
 * Authorbox Tab
 * @since 4.0
 */
WITHEMES.authorbox_tab = function() {
    
    $( document ).on( 'click', '.authorbox-nav a ', function( e ) {
        
        e.preventDefault();
        
        var btn = $( this ),
            nav = btn.closest( '.authorbox-nav' ),
            tab = btn.data('tab'),
            box = btn.closest( '.fox-authorbox' );
        
        if ( ! nav.length || ! box.length ) return;
        
        // nav active
        nav.find( 'li' ).removeClass( 'active' );
        btn.parent().addClass( 'active' );
        
        // content active
        box.find( '.authorbox-tab' ).removeClass( 'active' );
        
        box
        .find( '.authorbox-tab[data-tab="' + tab + '"]' )
        .addClass( 'active' );
    
    });
    
};	// tab    
    
/**
 * Slick Carousel
 * @since 2.0
 * @improved in 4.0
 */
WITHEMES.slick = function() {
    
	if ( ! $().slick ) return;
    
    $( '.fox-carousel:not(.loaded)' ).each( function() {
        
        var $this = $( this ),
            defaultOptions = {
                slidesToShow: 1,
                variableWidth: true,
                slide   : '.carousel-item',
                infinite: true,
                initialSlide :  0,
                speed       :   450,
                useTransform: true,
                
                // ease out cubic
                cssEase: 'cubic-bezier(0.215, 0.61, 0.355, 1)',
                
                dots        :   false,
                arrows      :   true,
                nextArrow   :   '<button type="button" class="slick-next slick-nav"><i class="fa fa-angle-right"></i></button>',
                prevArrow   :   '<button type="button" class="slick-prev slick-nav"><i class="fa fa-angle-left"></i></button>',
                swipeToSlide : true,
                touchMove : true,
            },
            args = $this.data( 'options' ),
            options = $.extend( defaultOptions, args );
        
        $this
        .addClass( 'loaded' )
        .find( '.fox-slick' )
        .slick( options )

    });
    
    // set image height depending on container width
    var resize = debounce( function() {

        $( '.fox-carousel' ).each( function() {

            var $this = $( this ),
                w = $this.outerWidth(),
                height = w*3/8; // normally, a reasonable height = 2/5 viewport

            if ( height < 250 ) height = 250; // 250 is the limit
            if ( height > 600 ) height = 600; // 600 is the limit

            $this.find( '.carousel-item img' ).css({
                height: height + 'px',
            });

        });

    }, 100 );

    resize();
    $( window ).on( 'resize', resize );
    
} // slick

/**
 * Flexslider
 * @since 1.0
 * @improved in 4.0
 */
WITHEMES.flexslider = function() {
    
	if ( ! $().flexslider ) return;
    
    $( '.fox-flexslider' ).each( function() {
        
        var $this = $( this ),
            defaultOptions = {
                animation: 'fade',
                smoothHeight : false,
                animationSpeed : 500,
                slideshowSpeed	:	5000,
                directionNav	:	true,
                slideshow		:	true,
                controlNav : false,
                pauseOnHover: true,
                
                prevText : '<i class="fa fa-angle-left"></i>',
                nextText : '<i class="fa fa-angle-right"></i>',
                
                start            :   function( slider ) {
                    $this.addClass('loaded');
                    slider.find( 'img' ).trigger( 'flexslider_complete' );
                    WITHEMES.masonry();
                }
            },
            args = $( this ).data( 'options' ),
            options = $.extend( defaultOptions, args );
        
        $this.imagesLoaded( function() {
            
            $this
            .addClass( 'loaded' )
            .find( '.flexslider' )
            .flexslider( options );
        
        });
    
    });
    
    // set image height depending on container width
    var resize = debounce( function() {
        
        $( '.fox-gallery-slider-rich' ).each( function() {
           
            var $this = $( this ),
                w = $this.outerWidth(),
                height = w*7/10; // tend to square form 70%
                
            if ( height < 250 ) height = 250; // 250 is the limit

            $this.find( '.rich-height-element' ).css({
                height: height + 'px',
            });
            
        });
    
    }, 100 );
    
    resize();
    $( window ).resize( resize );
    
}; // flexslider

/* Masonry
--------------------------------------------------------------------------------------------- */
WITHEMES.masonry = function() {
    
    if ( ! $().masonry ) return;
    
    var run = debounce( function() {
        
        $( '.fox-masonry' ).each(function() {
            
            var grid = $( this );
            
            grid.imagesLoaded(function() {
                
                var itemSelector = '.fox-masonry-item';
                if ( grid.hasClass( 'blog-newspaper' ) ) {
                    itemSelector = '.post-newspaper';
                }
            
                grid
                .addClass( 'loaded' )
                .masonry({
                    itemSelector: itemSelector,
                    columnWidth: '.grid-sizer',
                    percentPosition: true,
                })
                .find( itemSelector ).each(function() {
                
                    var item = $( this );
                    
                    item.bind('inview', function(event, isInView, visiblePartX, visiblePartY) {
                        if (isInView) {
                            item.addClass( 'inview' );
                        } // inview
                    }); // bind inview    
                
                });
            
            });
            
        });
        
        $( '.wi-pin-list' ).each(function() {

            var $this = $( this );

            $this.imagesLoaded( function() {

                $this
                .addClass( 'loaded' )
                .masonry({

                    itemSelector: '.pin-item',
                    columnWidth: '.grid-sizer',

                });

            });

        });
        
    }, 100 );
    
    run();
    $( window ).on( 'resize', run );
    
    var sidebar_masonry = debounce( function() {
        
        if ( ! window.matchMedia( '(max-width: ' + WITHEMES.tablet_breakpoint + 'px)' ).matches || ! window.matchMedia( '(min-width: 450px)' ).matches ) {
            return;
        }
        
        /**
         * sidebar on tablet
         * @since 4.3
         */
        $( '.secondary .widget-area, .section-secondary .widget-area' ).each(function() {
           
            var self = $( this );
            
            self.imagesLoaded( function( ) {
                
                self
                .addClass( 'loaded' )
                .masonry({
                    
                    itemSelector: '.widget',
                    columnWidth: '.gutter-sidebar',
                    
                })
                
            })
            
        });
        
    }, 100 );
    
    sidebar_masonry()
    $( window ).resize( sidebar_masonry );
}

/**
 * Back to top
 * @since 1.0
 */
WITHEMES.backtotop = function() {
    
    $(window).scroll(function(){
        if ($(this).scrollTop() > 200) {
            $('.backtotop').addClass('shown');
        } else {
            $('.backtotop').removeClass('shown');
        }
    }); 
	
	$('.backtotop').click(function(){
        
		$("html, body").animate({ scrollTop: 0 }, 600 , 'easeOutExpo');
		return false;
        
	});
	
}

/**
 * Social Share
 * @since 1.0
 */
WITHEMES.social_share = function(){
	
    var Config = {
        Link: "a.share",
        Width: 800,
        Height: 600
    };
 
    $( document ).on( 'click', 'a.share', function( e ) {
 
        e = (e ? e : window.event);
        var t = $(this);
 
        // popup position
        var
            px = Math.floor(((screen.availWidth || 1024) - Config.Width) / 2),
            py = Math.floor(((screen.availHeight || 700) - Config.Height) / 2);
 
        // open popup
		if(t.attr('href')) {
			var popup = window.open(t.attr('href'), "social", 
				"width="+Config.Width+",height="+Config.Height+
				",left="+px+",top="+py+
				",location=0,menubar=0,toolbar=0,status=0,scrollbars=1,resizable=1");
			if (popup) {
				popup.focus();
				if (e.preventDefault) e.preventDefault();
				e.returnValue = false;
			}
	 
			return !!popup;
		}
    }); // click

}

/**
 * Sticky Header
 * @since 4.0
 */
WITHEMES.header_sticky = function() {
    
    if ( ! $( '.header-sticky-element' ).length ) return;
    if ( ! WITHEMES.enable_sticky_header ) return;
    
    var init = debounce( function() {
        
        if ( ! window.matchMedia( '(min-width: ' + WITHEMES.tablet_breakpoint + 'px)' ).matches ) {
            return;
        }
    
        var header = $( '.header-sticky-element' ),
            header_top = header.offset().top,
            header_h = header.outerHeight(),
            delay_distance = 220;
        
            // set up header height
            if ( ! $( '.sticky-element-height' ).length ) {
                header.after( '<div class="sticky-element-height" />' ) 
            }
            $( '.sticky-element-height' ).css({height:header_h + 'px'});
        
            // background element
        if ( ! header.find( '.sticky-header-background' ).length ) {
            header.append( '<div class="sticky-header-background" />' );
        }

        function sticky() {

            if ( !header.length ) {
                return;
            }

            if ( $( window ).scrollTop() > header_top + header_h + delay_distance ) {
                header.addClass('before-sticky is-sticky');
            } else if ( $( window ).scrollTop() > header_top + header_h ) {
                header.removeClass('is-sticky');
                header.addClass('before-sticky');
            } else {
                header.removeClass('is-sticky before-sticky');
            }

        }

        sticky();
        $( window ).scroll( sticky );
        
    }, 100 );
    
    $( window ).on( 'load', init );
    $( window ).resize( init );
        
} 

/**
 * Minimal Header Sticky
 * @since 3.0
 */
WITHEMES.minimal_header_sticky = function() {
    
    var sticky = debounce( function() {
        
        var $vh = $( window ).outerHeight();
        
        $( window ).on( 'scroll',function() {
            
            if ( $(window).scrollTop() > $vh ) {
                $( '.minimal-header' ).removeClass( 'top-mode' );
            } else {
                $( '.minimal-header' ).addClass( 'top-mode' );
            }
            
        }); // on scroll
        
    }, 100 );
    
    $( window ).on( 'load', sticky );
    $( window ).resize( sticky );
    
}

/**
 * mobile transparent header
 * @since 4.4.4
 */
WITHEMES.mobile_transparent_header = function() {
    
    var sticky = debounce( function() {
        
        $( window ).on( 'scroll',function() {
            
            if ( $(window).scrollTop() > 100 ) {
                $( '#masthead-mobile' ).addClass( 'is-sticky' );
            } else {
                $( '#masthead-mobile' ).removeClass( 'is-sticky' );
            }
            
        }); // on scroll
        
    }, 100 );
    
    $( window ).on( 'load', sticky );
    $( window ).resize( sticky );
    
}

    
/**
 * Magnific Popup Lightbox
 * @since 4.0
 */
WITHEMES.lightbox = function() {
    
    // only false, if it's undefined then still keep it enabled
    if ( ! WITHEMES.enable_lightbox ) {
        return
    }

    if ( ! $().magnificPopup ) {
        return;
    }
    
    $( '.open-video-lightbox' ).magnificPopup({
        type: 'iframe',
    });
    
    var Images = [
        '.wi-colorbox',
        '.fox-lightbox-link',
        '.open-lightbox',
        '.wp-block-image a[href$=".gif"]', 
        '.wp-block-image a[href$=".GIF"]',
        '.wp-block-image a[href$=".jpg"]',
        '.wp-block-image a[href$=".JPG"]',
        '.wp-block-image a[href$=".jpeg"]', 
        '.wp-block-image a[href$=".JPEG"]',
        '.wp-block-image a[href$=".png"]',
        '.wp-block-image a[href$=".PNG"]', 
        '.wp-block-image a[href$=".bmp"]',
        '.wp-block-image a[href$=".BMP"]',
        '.wp-block-image a[href$=".webp"]',
        '.wp-block-image a[href$=".WEBP"]',
        
        '.wp-block-media-text__media a[href$=".gif"]',
        '.wp-block-media-text__media a[href$=".jpg"]',
        '.wp-block-media-text__media a[href$=".png"]',
        '.wp-block-media-text__media a[href$=".jpeg"]',
        '.wp-block-media-text__media a[href$=".webp"]',
    ];
    
    $.each( Images, function(k, link ) {
        
        $( link ).magnificPopup({
            type: 'image',
            image : {
                titleSrc: function(item) {

                    var text = item.el.closest( '.blocks-gallery-item,.fox-figure, .wp-block-image' ).find( 'figcaption,.fox-figcaption' );
                    if ( ! text.length ) return;

                    text = text.html();

                    if ( text.split( ' ' ).length > 12 ) {
                        return '<p class="lightbox-caption-long">' + text + '</p>';
                    } else {
                        return '<p class="lightbox-caption-short">' + text + '</p>';
                    }

                }
            }
        });
        
    });
    
    // in direct, so we must find another deeper a inside
    var inDirectArr = {
        '.gallery': '.gallery-item', 
        '.wp-block-gallery' : '.blocks-gallery-item',
        
    }
    var directArr = {
        '.fox-lightbox-gallery' : 'a.fox-lightbox-gallery-item',
    }
    var Galleries = Object.keys( inDirectArr ).concat( Object.keys( directArr ) );
    
    // note: gallery is string, not jquery selector
    $.each( Galleries, function( k, gallery ) {
           
        $( gallery ).each( function() {
            
            var delegate = '',
                _self = $( this )
        
            delegate = directArr[ gallery ];

            if ( undefined == delegate ) {

                delegate = inDirectArr[ gallery ];

                if ( undefined == delegate ) return;

                var formats = [ 'jpg', 'jpeg', 'png', 'bmp', 'webm', 'gif' ];
                var items = [];
                $.each( formats, function( i, format ) {

                    items.push( delegate + ' a[href$=".' + format + '"]' );
                    items.push( delegate + ' a[href$=".' + format.toUpperCase() + '"]' );

                });

                delegate = items.join( ',' );

            }
            
            
            if ( _self.is( '.fox-carousel' ) ) {
                delegate = '.carousel-item:not(.slick-cloned) ' + delegate;
            }
            
            var defaultOptions = {
                    type : 'image',
                    delegate : delegate,
                    removalDelay : 400,
                    zoom: {
                        // enabled: true,
                    },
                    gallery: {
                        enabled:true,
                        tCounter: '%curr% / <span class="total">%total%</span>',
                        arrowMarkup : '<button title="%title%" type="button" class="mfp-arrow mfp-arrow-%dir%"><i class="feather-chevron-%dir%"></i></button>',
                    },
                    image: {
                        // options for image content type
                        titleSrc: function(item) {

                            var text = item.el.closest( '.blocks-gallery-item,.fox-figure, figure.gallery-item' ).find( 'figcaption,.fox-figcaption' );
                            if ( ! text.length ) return '';

                            text = text.html();

                            if ( text.split( ' ' ).length > 12 ) {
                                return '<p class="lightbox-caption-long">' + text + '</p>';
                            } else {
                                return '<p class="lightbox-caption-short">' + text + '</p>';
                            }

                        }
                    },
                    closeBtnInside : true,
                    closeMarkup : '<button title="%title%" type="button" class="mfp-close"><i class="feather-x"></i></button>',

                    callbacks: {

                        beforeOpen: function() {
                            $( 'html' ).addClass( 'lightbox-open' )
                        },
                        afterClose: function() {
                            $( 'html' ).removeClass( 'lightbox-open' )
                        },

                        open: function() {

                            return;

                            $.magnificPopup.instance.next = function() {
                                var self = this;
                                self.wrap.removeClass( 'mfp-image-loaded' );
                                setTimeout(function() { $.magnificPopup.proto.next.call(self); }, 120);
                            }
                            $.magnificPopup.instance.prev = function() {
                                var self = this;
                                self.wrap.removeClass( 'mfp-image-loaded' );
                                setTimeout(function() { $.magnificPopup.proto.prev.call(self); }, 120);
                            }

                        },

                        imageLoadComplete: function() {	
                            var self = this;
                            setTimeout(function() { self.wrap.addClass('mfp-image-loaded'); }, 16);
                        },

                    }

                },
                args = $( gallery ).data( 'options' ),
                options = $.extend( defaultOptions, args );
            
            _self.magnificPopup( options );
            
        }); // each jquery selector
    
    }); // each Galleries

}

/**
 * Hero post scrolldown button
 * @since 4.0
 */
WITHEMES.scrollDown = function() {
    
    $( document ).on( 'click', '.scroll-down-btn', function( e ) {
        
        e.preventDefault();
        
        var hero = $( this ).closest( '.hero-section' );
        if ( ! hero.length ) return;
        
        var scrollTop = hero.offset().top + $( window ).outerHeight();
        if ( $( '#wpadminbar' ).length ) {
            scrollTop = scrollTop - $( '#wpadminbar' ).outerHeight();
        }
        
        $( "html, body").animate({ scrollTop: scrollTop + 'px' }, 400 , 'easeInOutQuint' );
        
    });
    
}

/**
 * Animation Problem
 * @since 4.0
 */
WITHEMES.animation = function(){
    
    $( '.fox-animation-element, .animation-element' ).each(function() {
    
        var $this = $( this );
        
        $this.bind( 'inview', function(event, isInView, visiblePartX, visiblePartY) {
            
            if ( isInView ) {

                $this.addClass( 'inview' );

            } // inview
            
        }); // bind
    
    });

}

/**
 * Header search
 * @since 4.0
 *
 * classic search and modal search
 */
WITHEMES.header_search = function(){
    
    /**
     * Classic Search
     */
    $( '.header-search-classic' ).each(function() {
        
        var wrapper = $( this ),
            header = wrapper.closest( '.header-row, .header-classic-row' ),
            btn = wrapper.find( '.search-btn-classic' ),
            template = wrapper.find( '.header-search-form-template' );
        
        if ( ! header.length ) return;
        if ( ! header.find( '> .header-search-form' ).length ) {
            header.append( template );
        }
    
    });
    
    $( document ).on( 'click', '.search-btn-classic', function( e ) {
        
        var header = $( this ).closest( '.header-row, .header-classic-row' );
        if ( ! header.length ) return;
        
        if ( $( this ).closest( '.before-sticky' ).length ) {
            $("html, body").animate({ scrollTop: 0 }, 300 , 'easeOutExpo', function(){

                header.find( '> .header-search-form' ).slideDown( 'fast','easeOutExpo' ).find( '.s' ).focus();

            });
        } else {
            
            header.find( '> .header-search-form' ).slideDown( 'fast','easeOutExpo' ).find( '.s' ).focus();
            
        }
        
    });
    
    $( document ).on( 'click', function( e ) {
        
        var currentTarget = $( e.target );
        if ( currentTarget.is( '.header-search-form, .search-btn-classic' ) || currentTarget.closest( '.header-search-form, .search-btn-classic' ).length ) {
        } else {
            
            // hide all search forms
            $( '.header-search-form' ).slideUp( 'fast' ,'easeOutExpo' );
        }
        
    });
    
    /**
     * Modal Search
     */
    $( '.header-search-modal' ).each(function() {
        
        var wrapper = $( this ),
            template = wrapper.find( '.modal-search-wrapper' );
        
        if ( ! $( 'body' ).find( '> .modal-search-wrapper' ).length ) {
            $( 'body' ).append( template );
        }
        
    });
    
    $( document ).on( 'click', '.search-btn-modal', function( e ) {
        
        onsearch();
        setTimeout(function() {
            $( '.modal-search-wrapper' ).find( '.s' ).focus();
        }, 100 );

    });
    
    $( document ).on( 'click', '.modal-search-wrapper .close-modal', function( e ) {
        
        offsearch();

    });
    
    function onsearch() {
        
        $( 'html' ).addClass( 'on-search' );
        
    }
    
    function offsearch() {
        
        $( 'html' ).removeClass( 'on-search' );
        
    }
    
}

/**
 * All control of menu
 * @since 4.0
 */
WITHEMES.menu = function() {
    
    var navSelector = $( '.wi-mainnav, .header-builder .widget_nav_menu' );
    
    // APPENDING a caret
    navSelector.each(function() {
        $( this ).find( 'ul.menu > li > ul' ).append( '<span class="caret" />' ); // since 4.0
    });
    
    // MEGA
    var setup_mega = function() {
        
        navSelector.find( 'ul.menu > li.mega' ).each(function() {

            var li = $( this );

            // COLUMN
            var col = li.find( '> ul' ).find( ' > li' ).length;
            if ( li.hasClass( 'menu-item-object-category' ) ) col = 3;

            if ( col > 0 ) {
                li.addClass( 'column-' + col );
            }
            if ( col >= 4 ) {
                li.addClass( 'mega-full' );
            }

            // please don't add for mega menu
            if ( ! li.hasClass( 'menu-item-object-category' ) && ! li.find( '> ul .mega-sep' ).length ) {
                for ( var i = 1; i <= col -1; i++ ) {
                    li.find( '> ul' ).append( '<span class="mega-sep mega-sep-' + i + '"></span>' )
                }
            }

            // ADJUST DROPDOWN ACCORDINGLY
            // MEGA POSITION
            var li_pos = li.parent().find( '> li' ).index( li );

            // margin left is a formula of column + position
            var marginLeft = 0;
            if ( li_pos == 2 ) {
                if ( col == 3 ) {
                    marginLeft = 200;
                }
            } else if ( li_pos >= 3 ) {
                if ( col == 2 ) {
                    marginLeft = 200;
                } else if ( col == 3 ) {
                    marginLeft = 300;
                }
            }

            if ( marginLeft > 0 ) {

                li.find( '>ul' ).css({
                    left: '50%',
                    'transform': 'translateX(-' + marginLeft + 'px)',
                });

                li.find( '> ul > .caret' ).css({
                    left: '-10px',
                    'transform': 'translateX(' + marginLeft + 'px)',
                });

            }

        });
        
    }
    
    setup_mega();
    
    var run_superfish = function() {
        
        if ( $().superfish ) {
        
            var args = {
                delay: 0,
                speed: 400,
                speedOut: 100,
                animation: {
                    opacity : 'show',
                },							   
            };
        
            navSelector.each(function() {

                $( this ).find( 'ul.menu' ).superfish( args );

            });
            
        }
        
    }
    
    run_superfish()
    
    // this runs when window is fully loaded
    $( window ).on( 'load', run_superfish );
    $( window ).on( 'resize', run_superfish );
    
    /**
     * only load on hover
     */
    
    var load_mega_dropdown = function( item ) {
        
        if ( item.data( 'loaded-item' ) ) {
            return;
        }
        
        var itemID = item.attr( 'id' );
        if ( itemID ) {
            itemID = parseInt( itemID.replace( 'menu-item-', '' ) );
        } else {
            return;
        }
        
        $.post(
            // url
            WITHEMES.ajaxurl,
            
            //data
            {
                action: 'nav_item_mega',
                item_id: itemID,
                nonce: WITHEMES.nonce,
            },
            
            // sucess function
            function( response ) {
                
                item.data( 'loaded-item', true );
                var ul = item.find( '.submenu-display-items' );
                if ( ! ul.length ) {
                    return;
                }
                
                if ( ! response ) {
                    return
                }
                
                ul.find( '>li' ).each( function( index ) {
                    
                    var li = $( this )
                    li.find( '.post-nav-item-text' ).html( response[ index ].title )
                    li.find( '.nav-thumbnail-wrapper' ).html( response[ index ].thumbnail )
                    
                });
                
            },
            
            'json'
            
        )
        
    }
    
    // MEGA MENU FOR CATEGORY
    var tax_nav_items = [];
    $( '.wi-mainnav ul.menu > li.menu-item-object-category.mega' ).each(function( index ) {
        
        var item = $( this );
        
        // item.append( '<ul class="sub-menu submenu-display-items" />' );
        
        item.on( 'mouseover', function() {
            
            load_mega_dropdown( item )
            
        })
        
        var $this = $( this ),
            itemID = $this.attr( 'id' );
            if ( itemID ) {
                itemID = parseInt( itemID.replace( 'menu-item-', '' ) );
                tax_nav_items[ index ] = itemID;
            }
        
    });
    
    /*
    if ( $( '.wi-mainnav ul.menu > li.menu-item-object-category.mega' ).length ) {
        
        // we collect all items so only call at once
        $.post(
            // the url
            WITHEMES.ajaxurl,

            // the data
            {
                action: 'nav_mega',
                items: tax_nav_items,
                nonce: WITHEMES.nonce,
            },

            function( response ) {

                $( '.wi-mainnav ul.menu > li.menu-item-object-category.mega' ).each(function( index ) {

                    var $this = $( this ),
                        itemID = $this.attr( 'id' );
                        if ( itemID ) {
                            $this.append( response[ index ] );
                        }

                });

                // set up mega again
                setup_mega();

            },

            'json'
        );
        
    }
    */
    
}

/**
 * Sticky Sidebar
 * @since 2.2
 */
WITHEMES.stickySidebar = function() {
    
    if ( ! $().theiaStickySidebar ) return;
        
    if ( ! window.matchMedia( '(min-width: ' + WITHEMES.tablet_breakpoint + 'px)' ).matches ) {
        return;
    }
    
    $( '.body-sticky-sidebar .primary, .body-sticky-sidebar .secondary, .section-sidebar-sticky .section-primary, .section-sidebar-sticky .section-secondary' ).theiaStickySidebar({
        // Settings
        additionalMarginTop: 80,
        additionalMarginBottom: 20,
        minWidth : WITHEMES.tablet_breakpoint,
    });

}

/**
 * WooCommerce Quantity Buttons
 * @since 2.4
 */
WITHEMES.woocommerce_quantity = function() {
    
    var insert_quan = function() {

        // Quantity buttons
        $( 'div.quantity:not(.buttons-added), td.quantity:not(.buttons-added)' )
        .addClass( 'buttons-added' )
        .append( '<input type="button" value="+" class="plus" />' )
        .prepend( '<input type="button" value="-" class="minus" />' );

        // Set min value
        $( 'input.qty:not(.product-quantity input.qty)' ).each ( function() {
            var qty = $( this ),
                min = parseFloat( qty.attr( 'min' ) );
            if ( min && min > 0 && parseFloat( qty.val() ) < min ) {
                qty.val( min );
            }
        });
        
    }
    
    insert_quan()
    
    $( document.body ).on( 'updated_cart_totals', function(){
        insert_quan()
    })

    // Handle click event
    $(document).on( 'click', '.plus, .minus', function() {

            // Get values
        var qty = $( this ).closest( '.quantity' ).find( '.qty' ),
            currentQty = parseFloat( qty.val() ),
            max = parseFloat( qty.attr( 'max' ) ),
            min = parseFloat( qty.attr( 'min' ) ),
            step = qty.attr( 'step' );

        // Format values
        if ( !currentQty || currentQty === '' || currentQty === 'NaN' ) currentQty = 0;
        if ( max === '' || max === 'NaN' ) max = '';
        if ( min === '' || min === 'NaN' ) min = 0;
        if ( step === 'any' || step === '' || step === undefined || parseFloat( step ) === 'NaN' ) step = 1;

        // Change the value
        if ( $( this ).is( '.plus' ) ) {

            if ( max && ( max == currentQty || currentQty > max ) ) {
                qty.val( max );
            } else {
                qty.val( currentQty + parseFloat( step ) );
            }

        } else {

            if ( min && ( min == currentQty || currentQty < min ) ) {
                qty.val( min );
            } else if ( currentQty > 0 ) {
                qty.val( currentQty - parseFloat( step ) );
            }

        }

        // Trigger change event
        qty.trigger( 'change' );

    });

}

/**
 * Content Dock
 * @since 2.5
 */
WITHEMES.contentDock = function() {

    var doc = $( '#content-dock' ),
        close = doc.find( '.close' );
    
    // added since 2.9
    if ( WITHEMES.enable_autoload ) return;

    // Setup Animation
    doc.find( '.post-dock' ).each(function( i ) {
        $( this ).css({
            '-webkit-transition-delay': ( 400 + 80 * i + 'ms' ),
            'transition-delay': ( 400 + 80 * i + 'ms' ),
        });
    });

    $(window).on( 'load', function() {
        
        $( '#wi-footer' ).bind('inview', function(event, isInView, visiblePartX, visiblePartY) {
            if (isInView) {

                if ( doc.data( 'never-show' ) ) return;

                doc.addClass( 'shown' );

                close.click(function( e ) {
                    e.preventDefault();
                    doc
                    .removeClass( 'shown' )
                    .addClass( 'dont-show-me-again' )
                    .data( 'never-show', true )
                });

            } // inview

        });

        close.click(function( e ) {
            e.preventDefault();
            doc
            .removeClass( 'shown' )
            .addClass( 'dont-show-me-again' )
            .data( 'never-show', true )
        });

    });
    
}

/**
 * Fullsize image in coll post
 * @since 2.9
 */
WITHEMES.fullsize_image = function() {

    var run = debounce( function() {
        
        var selector = '.allow-stretch-full .alignfull, .content-all-stretch-full .alignwide, .content-all-stretch-full .alignfull, .content-all-stretch-full .alignnone, .content-all-stretch-full .aligncenter, .content-all-stretch-full .wp-block-image'
        
        $( selector ).each( function() {
            
            var img = $( this ),
                parentW = img.parent().outerWidth(),
                vW = $( '#wi-wrapper' ).outerWidth(),
                margin = ( vW - parentW ) / 2;
            
            // don't do that for alignleft, alignright elements
            if ( img.find( '.alignleft' ).length || img.find( '.alignright' ).length ) {
                
                img
                .css({
                    opacity: 1,
                    visibility: 'visible',
                })
                .addClass( 'loaded' );
                
                return;
            }
            
            img
            .css({
                width: vW + 'px',
                'margin-left' : -margin + 'px',
                
                // by CSS
                opacity: 1,
                visibility: 'visible',
            })
            .addClass( 'loaded stretched' );
        
        });
    
    }, 100 );
    
    run();
    $( window ).resize( run );
    
}

/* Off Canvas Mobile Menu
 * @since 2.9
 */
WITHEMES.offcanvas = function() {
    
    var hamburger = $( '.toggle-menu' ),
        offcanvas = $( '#offcanvas' );
    
    var offcanvas_dismiss = debounce(function( e ) {

        e.preventDefault();
        $( 'html' ).removeClass( 'offcanvas-open' );

    }, 100 );

    $(document).on( 'click', '.toggle-menu', function( e ) {

        e.preventDefault();
        $( 'html' ).toggleClass( 'offcanvas-open' );

    });
    
    $(document).on( 'click', '.offcanvas-overlay', offcanvas_dismiss );

    // $(window).resize( offcanvas_dismiss );

    var running = false
    
    // Submenu Click
    $( '.offcanvas-nav li' ).click(function( e ) {

        var li = $( this ),
            a = li.find( '> a ' ),
            href = a.attr( 'href' ),
            target = $( e.target ),
            ul = li.find( '> ul' )
        
            // don't interupt running process
            if ( running ) {
                return;
            }

            var condition1 = ( ! target.is( ul ) && ! target.closest( ul ).length ),
            condition2 = ( ( ! target.is( a ) && ! target.closest( a ).length ) || ( ! href || '#' == href ) );

        if (  condition1 && condition2 ) {

            e.preventDefault();
            li.toggleClass( 'active' );
            running = true
            ul.slideToggle( 300, 'easeInOutCubic', function() {
                
                // set running false again
                running = false;
            } );

        }

    });

}

/**
 * Layz Load
 * @since 4.0
 */
WITHEMES.lazyload = function() {
    
    if ( ! $().Lazy ) return;
    
    $( '.lazyload-figure img[data-src], .pure-lazyload' ).each(function() {
        
        var args = {
            
            // your configuration goes here
            scrollDirection: 'vertical',
            effect: 'fadeIn',
            visibleOnly: true,
            enableThrottle: true,
            throttle: 250,
            delay: 0,
            afterLoad : function( element ) {
                var figure = element.closest( '.lazyload-figure' );
                figure.addClass( 'loaded' );
                
                /*
                if ( figure.hasClass( 'content-lazy' ) ) {
                    figure
                    .removeClass( 'custom-thumbnail' )
                    .find( '.height-element' ).remove()
                }
                */
            },
            onError: function(element) {
                console.log('error loading ' + element.data('src'));
            }
        }
        
        // if in elementor preview mode
        if ( $( 'body' ).hasClass( 'elementor-editor-preview' ) ) {
            args.delay = 0;
            args.visibleOnly = false;
        }
        
        $( this ).Lazy( args );
        
    }); // each
    
}

/**
 * Single reading progress
 * since 4.0
 */
WITHEMES.progress = function() {
    
    var progress = $( '.reading-progress-wrapper' ),
        postContent = $( '.single-main-content' );
    if ( ! progress.length ) return;
    if ( ! postContent.length ) return;

    var offsetBottom = postContent.offset().top + postContent.outerHeight();
    
    var getMax = function() {
        return offsetBottom;
    }

    var getValue = function(){
        var top = $( window ).scrollTop();
        if ( top > getMax() ) return getMax();
        else return top;
    }

    progress.attr( 'max', getMax() );

    $(document).on('scroll', function(){
        // On scroll only Value attr needs to be calculated
        progress.attr({ value: getValue() });
    });
    
    $( window ).on( 'load', debounce( function() {
        
        // too short
        if ( postContent.outerHeight() < $( window ).height() ) {
            progress.hide();
            return;
        } else {
            progress.show();
        }
        
        offsetBottom = postContent.offset().top + postContent.outerHeight();
        progress.attr( 'max', offsetBottom );
        
        
        
    }, 100 ) );
    
    // re-calculate offsetBottom on resize
    $( window ).resize( debounce( function() {
        
        // too short
        if ( postContent.outerHeight() < $( window ).height() ) {
            progress.hide();
            return;
        } else {
            progress.show();
        }
        
        offsetBottom = postContent.offset().top + postContent.outerHeight();
        progress.attr( 'max', offsetBottom );
        
    }, 100 ) );
    
}

/**
 * thumbnail in view effect
 * @since 4.3
 */
WITHEMES.thumbnail_inview_effect = function() {
    
    $( '.fox-thumbnail.thumbnail-loading, .blog-thumbnail-loading .fox-thumbnail' ).each( function() {
        
        var self = $( this )
        
        if ( self.hasClass( 'inview') ) {
            return
        }
        
        self.bind( 'inview', function(event, isInView, visiblePartX, visiblePartY) {
            
            if ( isInView ) {
                
                self.addClass( 'inview' );
                
            } // inview
            
        }); // bind inview    
        
    });
    
}

/**
 * reInit functions
 */
WITHEMES.reInit = function() {

    WITHEMES.masonry();
    WITHEMES.flexslider();
    WITHEMES.slick();
    WITHEMES.fitvids();
    WITHEMES.fullsize_image();
    WITHEMES.lightbox();
    WITHEMES.animation();
    WITHEMES.stickySidebar();
    WITHEMES.tooltip();
    WITHEMES.lazyload();
    
    // since 4.3
    WITHEMES.thumbnail_inview_effect();
    
}

/**
 * Init Functions
 */
$(document).ready(function() {
    
    /**
     * functions can run right away
     */
    WITHEMES.header_sticky();
    WITHEMES.minimal_header_sticky();
    WITHEMES.mobile_transparent_header(); // since 4.4.4
    WITHEMES.scrollDown();
    WITHEMES.backtotop();
    WITHEMES.offcanvas();
    WITHEMES.social_share();
    WITHEMES.authorbox_tab();
    WITHEMES.header_search();
    WITHEMES.menu();
    WITHEMES.woocommerce_quantity();
    WITHEMES.contentDock();
    WITHEMES.progress();
    
    /**
     * fucntions need to be reinited 
     */
    WITHEMES.reInit();
    
    /* autoload event handler */
    $( document ).on( 'autoload', function( e, posthtml ) {
        
        WITHEMES.reInit();
        
        if ( ! window.matchMedia( '(min-width: ' + WITHEMES.tablet_breakpoint + 'px)' ).matches ) {
            return;
        }

        posthtml.find( '.body-sticky-sidebar .primary, .body-sticky-sidebar .secondary' ).theiaStickySidebar({
            // Settings
            additionalMarginTop: 80,
            additionalMarginBottom: 20,
            minWidth : WITHEMES.tablet_breakpoint,
        });
        
        /*
        // sticky sidebar
        if (  posthtml.find( '.secondary' ).length ) {

            if ( ! $().theiaStickySidebar || ! WITHEMES.enable_sticky_sidebar ) return;

            if ( ! window.matchMedia( '(min-width: ' + WITHEMES.tablet_breakpoint + 'px)' ).matches ) {
                return;
            }

            posthtml.find( '.container' ).find( '.primary, .secondary' ).theiaStickySidebar({
                // Settings
                additionalMarginTop: 80,
                additionalMarginBottom: 20,
                minWidth : WITHEMES.tablet_breakpoint,
                containerSelector : posthtml.find( '.container' ),
            });

        }
        */

    }); // on autoload
						   
});
    
})( jQuery, WITHEMES );	// EOF