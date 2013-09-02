/* ==========================================================
 * MobilySlider
 * date: 20.1.2010
 * author: Marcin Dziewulski
 * last update: 02.02.2011
 * web: http://www.mobily.pl or http://playground.mobily.pl
 * email: hello@mobily.pl
 * Free to use under the MIT license.
 * ========================================================== */
(function($) {
$.fn.mobilyslider = function(options) {
  var defaults = {
    content : ".sliderContent",
    children : "div",
    transition : "fade",
    animationSpeed : 300,
    bullets : true,
    arrows : true,
    arrowsHide : true,
    prev : "prev",
    next : "next",
    animationStart : function() {
    },
    animationComplete : function() {
    }
  };
  var sets = $.extend({}, defaults, options);
    return this.each(function() {
      var $t = $(this),
        item = $t.children(sets.content).children(sets.children),
        step = 0,
        bullets = $t.find(".sliderBullets"),
        arrows = $t.find(".sliderArrows"),
        no = $t.children(".sliderBullets").children("a").length - 1,
        l = no,
        z,
        active,
        bullet;
        var slider = {
          init : function() {
            slider.data();
            slider.triggers();
          },
          data : function() {
            if (sets.transition == "fade") {
              item.hide().eq(0).show()
            }
          },
          slide : {
            fade : function() {
              sets.animationStart.call(this);
              item.fadeOut(sets.animationSpeed, function() {});
              $('#pink').load('slideshow/'+step+' #orange');
              item.eq(step).fadeIn(sets.animationSpeed, function() {
                sets.animationComplete.call(this)
              });
            }
          },
          animation : {
            previous : function() {
              step == 0 ? step = l : step--;
              z = -1;
              slider.slide.fade();
            },
            next : function() {
              step == l ? step = 0 : step++;
              z = 1;
              slider.slide.fade();
            }
          },
          bullets : {
            trigger : function() {
              bullet = bullets.find("a");
              bullet.eq(0).addClass("active");
              bullet.click(function() {
                var b = $(this), rel = b.attr("rel");
                active = bullet.filter(".active").attr("rel");
                step = rel;
                sign = rel > active ? "+" : "-";
                z = 0;
                if (!b.hasClass("active")) {
                  slider.slide.fade();
                }
                bullet.removeClass("active");
                b.addClass("active");
                return false
              })
            },
            update : function() {
              bullet.removeClass("active").eq(step).addClass("active")
            }
          },
          arrows : {
            trigger : function() {
              arrows.find("." + sets.prev).click(function() {
                slider.animation.previous();
                if (sets.bullets) {
                  slider.bullets.update()
                }
                return false
              });
              arrows.find("." + sets.next).click(function() {
                slider.animation.next();
                if (sets.bullets) {
                  slider.bullets.update()
                }
                return false
              });
              if (sets.arrowsHide) {
                arrows.hide();
                $t.hover(function() {
                  arrows.show()
                }, function() {
                  arrows.hide()
                })
              }
            }
          },
          triggers : function() {
            if (sets.arrows) {
              slider.arrows.trigger()
            }
            if (sets.bullets) {
              slider.bullets.trigger()
            }
          }
        };
        slider.init()
      })
    }
}(jQuery));
