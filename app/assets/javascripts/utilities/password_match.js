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

  if (password.value == passwordConfirmation.value) {
    hideIcons(dangerIcons);
    revealIcons(successIcons);
  } else if (password.value) {
    hideIcons(successIcons);
    revealIcons(dangerIcons);
  } else {
    hideIcons(successIcons);
    hideIcons(dangerIcons);
  }
}

function hideIcons(icons) {
  if (!icons[0].classList.contains('hide')) {
    icons.forEach(function(icon) {
      icon.classList.add('hide');
    })
  }
}

function revealIcons(icons) {
  if (icons[0].classList.contains('hide')) {
    icons.forEach(function(icon) {
      icon.classList.remove('hide');
    })
  }
}
