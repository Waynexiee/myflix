/**
 * Created by xiewangzhi on 18/02/2018.
 */

jQuery(function ($) {
  $('#payment-form').submit(function (event) {
    var $form = $(this);
    $form.find('button').prop('disabled',true);

    Stripe.createToken($form, stripeResponseHandler);

    return false;
  });
});

var stripeResponseHandler = function (status, response) {
  var $form = $('#payment-form');
  if (response.error) {
      $form.find('.payment-errors').text(response.error.message);
      $form.find('button').prop('disabled', false);
  } else {
      var token = response.id;
      $form.append($('<input type="hidden" name="stripeToken" />').val(token));
      $form.get(0).submit();
  }
};
// var form = document.getElementById('payment-form');
// form.addEventListener('submit', function(event) {
//     event.preventDefault();
//
//     stripe.createToken(card).then(function(result) {
//         if (result.error) {
//             // Inform the user if there was an error
//             var errorElement = document.getElementById('payment-errors');
//             errorElement.textContent = result.error.message;
//         } else {
//             // Send the token to your server
//             stripeTokenHandler(result.token);
//         }
//     });
// });