(function($) {
  $.fn.extend({
    method: function() {
      console.log(this);
    }
  });

  $.methodDefaultOptions = {};
})(jQuery);
