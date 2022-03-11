import { slugifyString } from './modules/slugify_string'

function initializeSlugifyOnSlugInputs () {
  const inputFields = document.querySelectorAll('input.slug')

  inputFields.forEach((inputField) => {
    inputField.addEventListener('input', (evt) => {
      const inputFieldValue = inputField.value
      const sluggedValue = slugifyString(inputFieldValue)

      inputField.value = sluggedValue
    })
  })
}

document.addEventListener('turbo:load', () => {
  initializeSlugifyOnSlugInputs()
})
