import flatpickr from 'flatpickr'

function initializeFlatpickrDateOnInputs () {
  const inputFields = document.querySelectorAll('input.date_picker')
  const inputOptions = {
    allowInput: true,
    altFormat: 'F j, Y',
    altInput: true,
    dateFormat: 'Y-m-d',
    enableTime: false
  }

  inputFields.forEach((inputField) => {
    flatpickr(inputField, inputOptions)
  })
}

document.addEventListener('turbolinks:load', () => {
  initializeFlatpickrDateOnInputs()
})
