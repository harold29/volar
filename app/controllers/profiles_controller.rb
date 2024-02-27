class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[ show update edit ]

  def show
    if current_user
      if @profile
        authorize @profile

        @profile
      else
        not_found!
      end
    else
      render status: :unauthorized
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    if current_user
      @profile = Profile.new(profile_params)
      @profile.user = current_user

      authorize @profile

      if @profile.save
        redirect_to @profile
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    redirect_to new_profile_path unless @profile
  end

  def update
    if current_user
      if @profile.update(profile_params)
        redirect_to @profile
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find_by_user_id(current_user.id)
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number_1, :phone_number_2, :gender, :birthday)
  end

  def with_error_handler(&block)
    begin
      block&.call
    end
  end
end
