import { slugifyString } from './modules/slugify_string'

function initializeSlugifyOnSubdomainInputs () {
  const inputFields = document.querySelectorAll('input.subdomain')

  inputFields.forEach((inputField) => {
    inputField.addEventListener('input', (evt) => {
      const inputFieldValue = inputField.value
      const sluggedValue = slugifyString(inputFieldValue)

      inputField.value = sluggedValue
    })
  })
}

document.addEventListener('turbo:load', () => {
  initializeSlugifyOnSubdomainInputs()
})
