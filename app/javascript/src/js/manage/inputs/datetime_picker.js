import flatpickr from 'flatpickr'

function initializeFlatpickrDatetimeOnInputs () {
  const inputFields = document.querySelectorAll('input.datetime_picker')
  const inputOptions = {
    altFormat: 'F j, Y @ h:i K',
    altInput: true,
    dateFormat: 'Y-m-d H:i:00',
    enableTime: true
  }

  inputFields.forEach((inputField) => {
    flatpickr(inputField, inputOptions)
  })
}

document.addEventListener('turbolinks:load', () => {
  initializeFlatpickrDatetimeOnInputs()
})
