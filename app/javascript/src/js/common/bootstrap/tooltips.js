import { Tooltip } from 'bootstrap'

function bootstrapTooltipInit () {
  const tooltips = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))

  tooltips.forEach((tooltip) => {
    const tooltipElem = new Tooltip(tooltip, { trigger: 'hover' })

    tooltip.addEventListener('click', (evt) => {
      tooltipElem.hide()
    })
  })
}

document.addEventListener('turbo:load', () => {
  bootstrapTooltipInit()
})
