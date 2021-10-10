# frozen_string_literal: true

class ManageController < ApplicationController
  include Pundit
  include Controllers::ActionConcern

  before_action :authenticate_user!
  after_action :verify_authorized

  layout 'manage'
end
