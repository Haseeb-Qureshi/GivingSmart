module Gsapi
  class OrganizationsController < ApplicationController
    def current_user
      render json: current_user, only: [:email, :name, :admin, :cover_image]
    end
  end
end
