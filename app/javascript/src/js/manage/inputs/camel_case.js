// import $ from 'jquery'

import { camelCasifyString } from './modules/camel_casify_string'

function initializeCamelizeOnCamelCaseInputs () {
  const inputFields = document.querySelectorAll('input.camel_case')
  const timeoutMilliseconds = 500

  let camelCaseTimeout

  inputFields.forEach((inputField) => {
    inputField.addEventListener('input', (evt) => {
      clearTimeout(camelCaseTimeout)

      camelCaseTimeout = setTimeout(() => {
        const inputFieldValue = inputField.value
        const sluggedValue = camelCasifyString(inputFieldValue)

        inputField.value = sluggedValue
      }, timeoutMilliseconds)
    })
  })
}

//
// Attach camel case after cocoon insert
//
// When a content store is added, attach action to camelize the text
//
function initializeCamelizeOnCocoonCamelCaseInputs () {
  const nestedContainer = document.querySelector('#content_stores')

  if (nestedContainer == null) {
    return
  }

  nestedContainer.addEventListener('cocoon:after-insert', (evt) => {
    initializeCamelizeOnCamelCaseInputs()
  })
}

document.addEventListener('turbo:load', () => {
  initializeCamelizeOnCamelCaseInputs()
  initializeCamelizeOnCocoonCamelCaseInputs()
})
