// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start()
require('@rails/activestorage').start()
require('@hotwired/turbo-rails')

require('@oddcamp/cocoon-vanilla-js')
require('bootstrap')

// Bootstrap
require('src/js/common/bootstrap/alerts')
require('src/js/common/bootstrap/tooltips')

// Flatpickr
require('src/js/common/flatpickr/defaults')

// Jodit
require('src/js/common/jodit/defaults')

// Simpleform Custom Inputs
require('src/js/manage/inputs/camel_case')
require('src/js/manage/inputs/date_picker')
require('src/js/manage/inputs/datetime_picker')
require('src/js/manage/inputs/slug')
require('src/js/manage/inputs/subdomain')
require('src/js/manage/inputs/time_picker')
require('src/js/manage/inputs/username')
require('src/js/manage/inputs/wysiwyg')

// Switcher
require('src/js/manage/switcher')

// Navigation
require('src/js/manage/navigation')

// Sections
require('src/js/manage/collections/collection_entries/sortable')

// Images
require.context('./images', true)
