# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_site

  protected

  def current_site
    @current_site ||= locate_current_site
  end

  def locate_current_site
    session_site = session.fetch(:archangel_site, nil)

    available_sites = Site.where(id: locate_accessible_sites)

    if session_site.blank?
      available_sites.order(name: :asc).first
    else
      available_sites.find_by(id: session_site)
    end
  end

  def locate_accessible_sites
    UserSite.where(user_id: current_user.id).select(:site_id)
  end
end
