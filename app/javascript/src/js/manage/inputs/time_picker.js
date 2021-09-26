import flatpickr from 'flatpickr'

function initializeFlatpickrTimeOnInputs () {
  const inputFields = document.querySelectorAll('input.time_picker')
  const inputOptions = {
    allowInput: true,
    altFormat: 'h:i K',
    altInput: true,
    dateFormat: 'H:i:00',
    enableTime: true,
    noCalendar: true
  }

  inputFields.forEach((inputField) => {
    flatpickr(inputField, inputOptions)
  })
}

document.addEventListener('turbolinks:load', () => {
  initializeFlatpickrTimeOnInputs()
})
