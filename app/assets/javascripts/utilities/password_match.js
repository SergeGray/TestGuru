document.addEventListener('turbolinks:load', function() {
  var password = document.querySelector('input[id=user_password]');
  var passwordConfirmation = document.querySelector('input[id=user_password_confirmation]');
  
  if (password && passwordConfirmation) {
    password.addEventListener('change', passwordCompare);
    passwordConfirmation.addEventListener('change', passwordCompare);
  }
})

function passwordCompare(confirmationEvent) {
  var password = document.querySelector('input[id=user_password]');
  var passwordConfirmation = document.querySelector('input[id=user_password_confirmation]');
  var successIcons = document.querySelectorAll('.octicon-check');
  var dangerIcons = document.querySelectorAll('.octicon-stop');

  if (passwordConfirmation.value) {
    if (password.value == passwordConfirmation.value) {
      // hide danger icons and reveal success icons
      if (successIcons[0].classList.contains('hide')) {
        dangerIcons.forEach(function(icon) {
          icon.classList.add('hide');
        })
        successIcons.forEach(function(icon) {
          icon.classList.remove('hide');
        })
      }
    } else {
      // hide success icons and reveal danger icons
      if (dangerIcons[0].classList.contains('hide')) {
        successIcons.forEach(function(icon) {
          icon.classList.add('hide');
        })
        dangerIcons.forEach(function(icon) {
          icon.classList.remove('hide');
        })
      }
    }
  } else {
    // hide all icons
    if (!successIcons[0].classList.contains('hide')) {
      successIcons.forEach(function(icon) {
        icon.classList.add('hide');
      })
    }
    if (!dangerIcons[0].classList.contains('hide')) {
      dangerIcons.forEach(function(icon) {
        icon.classList.add('hide');
      })
    }
  }
}
