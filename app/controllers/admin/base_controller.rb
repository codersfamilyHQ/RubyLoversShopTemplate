# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_user!
    before_action :authorize_admin!

    private

    def authorize_admin!
      unless current_user.admin?
        flash[:error] = 'You are not authorized'
        redirect_to root_path
      end
    end
  end
end
