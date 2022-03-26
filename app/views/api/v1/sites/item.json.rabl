# frozen_string_literal: true

object @site
attributes :name, :subdomain,
           :format_date, :format_datetime, :format_time, :format_js_date, :format_js_datetime, :format_js_time

child :stores, if: ->(obj) { obj.association(:stores).loaded? } do
  extends 'api/v1/stores/item'
end
