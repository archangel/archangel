function activeNavItem () {
  const path = window.location.pathname
  const parts = path.split('/')
  const navLinks = document.querySelectorAll('#sidebarMenu .nav-link')

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

document.addEventListener('turbolinks:load', () => {
  activeNavItem()
})

document.addEventListener('turbolinks:render', () => {
  activeNavItem()
})
