import slugify from 'slugify'

import { slugifyOptions } from '../../common/slugify/modules/options'

function initializeSlugifyOnUsernameInputs () {
  const inputFields = document.querySelectorAll('input.username')
  const inputOptions = slugifyOptions

  inputFields.forEach((inputField) => {
    // const originField = document.querySelector(originElem)
    // const destinationField = document.querySelector(destinationElem)
    //
    // if (originField === null) {
    //   return false
    // }
    //
    // originField.addEventListener('blur', (evt) => {
    //   if (destinationField.value !== '') {
    //     return false
    //   }
    //
    //   const originFieldValue = originField.value
    //   const sluggedValue = slugify(originFieldValue, slugifyOptions())
    //
    //   destinationField.value = sluggedValue
    // })
  })
}

document.addEventListener('turbolinks:load', () => {
  initializeSlugifyOnUsernameInputs()
})
