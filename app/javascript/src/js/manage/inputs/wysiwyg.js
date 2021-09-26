import { Jodit } from 'jodit'

/**
 * Add Jodit WYSIWYG editor to textarea
 *
 * A data attribute can be added to the field to set the editor mode.
 * `data-default-mode="1"` is the WYSIWYG editor
 * `data-default-mode="2"` is the source editor
 * `data-default-mode="3"` is split mode where the WYSIWYG editor and source editor are shown
 *
 * @example
 *   <textarea class="wysiwyg"></textarea>
 *   <textarea class="wysiwyg" data-default-mode="2"></textarea>
 */
function initializeJoditWysiwygOnInputs () {
  const inputFields = document.querySelectorAll('textarea.wysiwyg')

  inputFields.forEach((inputField) => {
    const inputOptions = {}
    const defaultMode = inputField.getAttribute('data-default-mode')

    if (defaultMode) {
      inputOptions.defaultMode = defaultMode
    }

    Jodit.make(inputField, inputOptions)
  })
}

document.addEventListener('turbolinks:load', () => {
  initializeJoditWysiwygOnInputs()
})
