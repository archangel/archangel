/**
 * Retrieve CSRF token
 *
 * @example
 *   import { metaCsrfToken } from './modules/meta/csrf_token'
 *
 *   metaCsrfToken() => abc123
 */
export function metaCsrfToken () {
  const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]')

  if (!csrfTokenMeta) {
    return ''
  }

  return csrfTokenMeta.getAttribute('content')
}
