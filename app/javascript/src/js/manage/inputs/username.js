import { slugifyString } from './modules/slugify_string'

function initializeSlugifyOnUsernameInputs () {
  const inputFields = document.querySelectorAll('input.username')

  inputFields.forEach((inputField) => {
    inputField.addEventListener('input', (evt) => {
      const inputFieldValue = inputField.value
      const sluggedValue = slugifyString(inputFieldValue)

      inputField.value = sluggedValue
    })
  })
}

document.addEventListener('turbolinks:load', () => {
  initializeSlugifyOnUsernameInputs()
})
