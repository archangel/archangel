import flatpickr from 'flatpickr'

function flatpickrInit () {
  flatpickr.defaultConfig.allowInput = true
  // flatpickr.defaultConfig.disableMobile = true // Show on mobile
  // flatpickr.defaultConfig.static = true
}

document.addEventListener('turbolinks:load', () => {
  flatpickrInit()
})
