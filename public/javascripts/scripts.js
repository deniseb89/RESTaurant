$(document).ready(function(){

// ****USERNAME****
  $userNameInput = $("#user_name");
  $userNameError = $("#user_name_error");
  $userNameInput.on("keyup", function(e){
    var name = $(this).val();
    if (isValidUserName(name)){
      $userNameError.css('color', 'green');
    } else {
      $userNameError.css('color', 'red');
    }
  });

// ****PHONE****
  $phoneInput = $("#user_ph");
  $phoneError = $("#user_ph_error");
  $phoneInput.on("keyup", function(e){
    var number = $(this).val();
    if (isValidPhone(number)){
      $phoneError.css('color', 'green');
    } else {
      $phoneError.css('color', 'red');
    }
  });

  // ****EMAIL****
  $emailInput = $("#user_email");
  $emailError = $("#user_email_error");
  $emailInput.on("keyup", function(e){
    var email = $(this).val();
    if (isValidEmail(email)){
      $emailError.css('color', 'green');
    } else {
      $emailError.css('color', 'red');
    }
  });

  // ****PASSWORD****
  $passwordInput = $("#user_password");
  $passwordConfirmationInput = $("#user_password_confirmation");
  $passwordError = $("#user_password_error");
  $passwordConfirmationInput.on("keyup", function(e){
    var password = $passwordInput.val();
    var passwordconf = $(this).val();
    if (passwordsMatch(password, passwordconf)) {
      $passwordError.css('color', 'green');
    } else {
      $passwordError.css('color', 'red');
    }
  });

  //set up event for form submit
  $form = $("#add_user_data");
  $form.on("submit", function(e){
    if (isValidPhone($phoneInput.val()) && isValidSuit($suitInput.val()) && isValidAge($ageInput.val()) && isValidEmail($emailInput.val()) && isValidUserName($userNameInput.val()) && passwordsMatch(passwordconf.val())) {

    } else {
      e.preventDefault();
      // return false;
    }
  });

});

function isValidUserName(name) {
  if (name.length > 3) {
    return true;
  } else {
    return false;
  }
}; 

function isValidPhone(number) {
  //This is a regular expression for a phone
  var phoneRegex = /^[0-9]+[0-9]+[0-9]+[_.-]+[0-9]+[0-9]+[0-9]+[_.-]+[0-9]+[0-9]+[0-9]+[0-9]$/;

  if(phoneRegex.test(number)) {
    return true;
  }
  else {
    return false;
  }
};

function isValidEmail(email) {
  //This is a regular expression for email
  var emailRegex = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/;

  if(emailRegex.test(email)) {
    return true;
  } else {
    return false;
  }
};

function passwordsMatch(password, passwordconf) {
  if (passwordconf === password) {
    return true;
  } else {
    return false;
  }
};

