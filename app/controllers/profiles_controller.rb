# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show update]

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

  def create
    return unless current_user

    @profile = Profile.new(profile_params)
    @profile.user = current_user

    authorize @profile

    if @profile.save
      render :show, status: :created, location: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end


  def update
    return unless current_user

    if @profile.update(profile_params)
      # redirect_to @profile
      render :show, status: :ok, location: @profile
    else
      # render :edit, status: :unprocessable_entity
      render json: @profile.errors, status: :unprocessable_entity
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
    block&.call
  end
end
