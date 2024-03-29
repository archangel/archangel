function activeNavItem () {
  const path = window.location.pathname
  const parts = path.split('/')
  const navLinks = document.querySelectorAll('#sidebar .nav-link')

  let route = '/' + parts[1]

  if (parts.length > 2) {
    route += '/' + parts[2]
  }

  navLinks.forEach((navLink) => {
    const pathName = navLink.pathname

    navLink.classList.remove('active')

    if (pathName === route) {
      navLink.classList.add('active')
    }
  })
}

document.addEventListener('turbo:load', () => {
  activeNavItem()
})

document.addEventListener('turbo:render', () => {
  activeNavItem()
})
