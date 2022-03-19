import { Turbo } from '@hotwired/turbo-rails'

function siteSwitcherCacheClearOnClick () {
  const switchOptions = document.querySelectorAll('#secondary-menu ul.switcher li.switcher-item a')

  switchOptions.forEach((switchOption) => {
    switchOption.addEventListener('click', (evt) => {
      Turbo.clearCache()
    })
  })
}

document.addEventListener('turbo:load', () => {
  siteSwitcherCacheClearOnClick()
})
