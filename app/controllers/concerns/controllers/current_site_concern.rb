# frozen_string_literal: true

# Controller concern
module Controllers
  # Current site helpers
  #
  # Helpers for identifying the current site
  #
  # Example
  #   class ExamplesController < ApplicationController
  #     include Controllers::CurrentSiteConcern
  #   end
  module CurrentSiteConcern
    extend ActiveSupport::Concern

    included do
      before_action :current_site

      helper_method :current_site
      helper_method :current_user_sites
    end

    protected

    def current_user_sites
      @current_user_sites ||= current_user.user_sites.includes(%i[site]).where(site: { discarded_at: nil })
    end

    def current_site
      @current_site ||= locate_current_site
    end

    def identify_current_site
      cookies.fetch(:_archangel_site, nil)
    end

    def locate_current_site
      session_site = identify_current_site
      available_sites = Site.where(discarded_at: nil).where(id: locate_accessible_sites)

      if session_site.blank?
        available_sites.order(name: :asc).first
      else
        available_sites.find_by(id: session_site)
      end
    end

    def locate_accessible_sites
      UserSite.where(user_id: current_user&.id).select(:site_id)
    end
  end
end
