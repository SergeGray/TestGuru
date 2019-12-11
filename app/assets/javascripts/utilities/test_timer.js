document.addEventListener('turbolinks:load', function() {
  var timer = document.querySelector('.test-timer');

  if (timer && toSeconds(timer.innerHTML) > 0) {
    timer.classList.remove('hide');
    startTimer(timer);
  }
})

function toFormat(seconds) {
  var minutes = Math.floor(seconds / 60);
  var hours = Math.floor(minutes / 60);
  var seconds = seconds % 60
  return [
    hours, minutes, seconds
  ].map(x => x.toString().padStart(2, '0')).join(':');
}

function toSeconds(format) {
  var hours = 0;
  var minutes = 0;
  var seconds = 0;
  [
    hours, minutes, seconds
  ] = format.split(':').map(x => parseInt(x));
  return seconds + minutes * 60 + hours * 3600
}

function startTimer(timer) {
  var timeLeft = toSeconds(timer.innerHTML);

  var deadline = Date.now() + timeLeft * 1000;

  var x = setInterval(function() {
    timeLeft = timeLeft - 1;
    timer.innerHTML = toFormat(timeLeft);

    if (deadline - Date.now() < 0) {
      clearInterval(x);
      window.location = timer.dataset.attemptId + '/result';
    }
  }, 1000);
}
