# frozen_string_literal: true

module Archangel
  module TestingSupport
    module VueHelpers
      # Wait for Vue
      #
      # Similar to `wait_for` but injects `Vue.nextTick` to the source to wait for Vue to finish the work it is doing.
      # Does not accept a block argument like `wait_for` does.
      #
      # @example
      #   it 'logs in' do
      #     visit '/foo/bar'
      #     wait_for_vue
      #     click_button 'Login'
      #     expect(page).to have_content('You are logged in')
      #   end
      def wait_for_vue(timeout = Capybara.default_max_wait_time)
        return unless vue_loaded?

        setup_vue_ready

        start = Time.current

        until vue_ready?
          vue_timeout! if vue_timeout?(start, timeout)
          setup_vue_ready if page_reloaded_on_vue_wait?

          sleep(0.01)
        end
      end

      protected

      def setup_vue_ready
        page.execute_script <<-JS
          window.vueReady = false;
          Vue.nextTick(function() {
            window.vueReady = true;
          });
        JS
      end

      def vue_ready?
        page.evaluate_script('window.vueReady')
      end

      def vue_timeout?(start, wait_time)
        (Time.current - start) > wait_time
      end

      def vue_timeout!
        raise TimeoutError 'timeout while waiting for Vue'
      end

      def vue_loaded?
        page.evaluate_script "(typeof Vue !== 'undefined')"
      rescue Capybara::NotSupportedByDriverError
        false
      end

      def page_reloaded_on_vue_wait?
        page.evaluate_script('window.vueReady === undefined')
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::VueHelpers, type: :system, js: true
end
