import { Alert } from 'bootstrap'

function bootstrapAlertInit () {
  const alerts = [].slice.call(document.querySelectorAll('#flash .alert'))

  alerts.forEach((alert) => {
    const alertElem = new Alert(alert)
    window.setTimeout(() => { alertElem.close() }, 3000)
  })
}

document.addEventListener('turbo:load', () => {
  bootstrapAlertInit()
})
