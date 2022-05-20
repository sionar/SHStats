class Api::UsersController < ApplicationController
  def index
    render :index, status: 200
  end
end
