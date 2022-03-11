import flatpickr from 'flatpickr'

function initializeFlatpickrDateOnInputs () {
  const inputFields = document.querySelectorAll('input.date_picker')
  const inputOptions = {
    altFormat: 'F j, Y',
    altInput: true,
    dateFormat: 'Y-m-d',
    enableTime: false
  }

  inputFields.forEach((inputField) => {
    flatpickr(inputField, inputOptions)
  })
}

document.addEventListener('turbo:load', () => {
  initializeFlatpickrDateOnInputs()
})
