import { Jodit } from 'jodit'

Jodit.defaultOptions.beautifyHTML = false
Jodit.defaultOptions.buttons = [
  'source',
  '|',
  'bold', 'underline', 'italic',
  '|',
  'link', 'image', 'video', 'table',
  '|',
  'ul', 'ol',
  '|',
  'align', 'outdent', 'indent',
  '|',
  'eraser', 'brush'
]
Jodit.defaultOptions.disablePlugins = [
  'font',
  'formatBlock',
  'fullsize',
  'mobile',
  'redoundo',
  'symbols'
]
Jodit.defaultOptions.cleanHTML = {
  removeEmptyElements: false,
  fillEmptyParagraph: false,
  replaceNBSP: false
}
Jodit.defaultOptions.showCharsCounter = false
Jodit.defaultOptions.showWordsCounter = false
Jodit.defaultOptions.spellcheck = false
Jodit.defaultOptions.toolbarAdaptive = false
Jodit.defaultOptions.toolbarSticky = false
