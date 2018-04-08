$(document).on("turbolinks:load", function() {
  $('#use_billing').click(function() {
    $('#order_shipping_address').toggleClass('hidden');
  });
});
