import { Alert } from 'bootstrap'

function bootstrapAlertInit () {
  const alerts = [].slice.call(document.querySelectorAll('.alert'))

  alerts.forEach((alert) => {
    const alertElem = new Alert(alert)
    window.setTimeout(() => { alertElem.close() }, 3000)
  })
}

document.addEventListener('turbolinks:load', () => {
  bootstrapAlertInit()
})
