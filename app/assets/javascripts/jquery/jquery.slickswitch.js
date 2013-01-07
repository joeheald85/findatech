/**
* jQuery SlickSwitch
*
* For documentation, see http://michaelgolus.com/projects/slickswitch/
*
* Copyright (c) 2011 Matt and Michael Golus
* Dual licensed under the MIT and GPL licenses:
* http://www.opensource.org/licenses/mit-license.php
* http://www.gnu.org/licenses/gpl.html
*
* Version: 1.0
* Modified by Sproutlet on 9/29/2012 to trigger change on checkbox
* Modified by Sproutlet on 10/1/2012 to switch on and off labels
*/

(function ($) {
    var methods = {
        init: function (options) {
            var settings = {
                cssPrefix: 'ss-',
                useAnimation: true,
                toggled: function () { },
                toggledOn: function () { },
                toggledOff: function () { }
            };

            if (options) {
                $.extend(settings, options);
            }

            this.each(function () {
                var self = $(this);
                var div = $('<a>');

                self.bind('ss-toggle', function () {
                    if (self.is(':checked')) {
                        self.removeAttr('checked').change();
                        settings.toggledOff(self);
                    } else {
                        self.attr('checked', 'checked').change();
                        settings.toggledOn(self);
                    }
                    self.trigger('ss-update');
                    settings.toggled(self);
                });

                self.bind('ss-toggleOn', function () {
                    self.attr('checked', 'checked').change();
                    self.trigger('ss-update');
                    settings.toggledOn(self);
                    settings.toggled(self);
                });

                self.bind('ss-toggleOff', function () {
                    self.removeAttr('checked').change();
                    self.trigger('ss-update');
                    settings.toggledOff(self);
                    settings.toggled(self);
                });

                self.bind('ss-update', function (o, disableAnimation) {
                    if (self.is(':checked')) {
                        $('span:eq(0)', div).show(settings.useAnimation && !disableAnimation ? 100 : 0);
                        $('span:eq(1)', div).animate({ left: div.width() - $('span:eq(1)', div).outerWidth(true) + 'px' }, settings.useAnimation && !disableAnimation ? 100 : 0);
                        $(self).closest('.switcher').find('.on').show().end().find('.off').hide();
                    } else {
                        $('span:eq(0)', div).hide(settings.useAnimation && !disableAnimation ? 100 : 0);
                        $('span:eq(1)', div).animate({ left: '0px' }, settings.useAnimation && !disableAnimation ? 100 : 0);
                        $(self).closest('.switcher').find('.on').hide().end().find('.off').show();
                    }
                });

                self.after(
					div.attr('class', self.attr('class'))
						.append($('<span>').addClass(settings.cssPrefix + 'on'))
						.append($('<span>').addClass(settings.cssPrefix + 'slider'))
						.click(function () {
						    // Custom: if inside a switcher label, click the label instead
						    if( self.parent('label').hasClass('switcher') ){
						        self.parent('label').click();
						    } else {
						        self.trigger('ss-toggle');
						    }
						    
						    return false;
						})
				)

                self.trigger('ss-update', true);
                self.hide();
            })
        },
        toggle: function () {
            $(this).trigger('ss-toggle');
        },
        toggleOn: function () {
            $(this).trigger('ss-toggleOn');
        },
        toggleOff: function () {
            $(this).trigger('ss-toggleOff');
        }
    };


    $.fn.slickswitch = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist');
        }
    };
})(jQuery);

