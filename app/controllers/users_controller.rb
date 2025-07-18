class UsersController < ApplicationController
  before_action :redirect_to_root, if: :signed_in?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.policies_acknowledged_at = Time.zone.now
    if @user.save
      Mailer.email_confirmation(@user).deliver_later
      flash[:notice] = t(".email_sent")
      redirect_back_or_to root_path
    else
      render template: "users/new"
    end
  end

  private

  PERMITTED_USER_PARAMS = %i[
    bio
    email
    handle
    public_email
    location
    password
    website
    twitter_username
    full_name
  ].freeze

  def user_params
    params.expect(user: PERMITTED_USER_PARAMS)
  end
end
