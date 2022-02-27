# frozen_string_literal: true

##
# Check or uncheck a checkbox
#
# Used with Selenium (js: true)
#
# Usage
#   form_checbox_check('My Checkbox label', true)
#   form_checbox_check('My Checkbox label', false)
#
def form_checbox_check(label, checked)
  return unless page.has_css?('label', text: label)

  id = find('label', text: label)[:for]

  find("label[for='#{id}'] + input[type='hidden'] + input[type='checkbox']").set(checked)
end
