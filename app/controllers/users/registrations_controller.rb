# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user][:password] = params[:user][:password]

    @profile = @user.build_profile
    render :new_profile
  end


  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    unless @profile.valid?
      flash.now[:alert] = @profile.errors.full_messages
      render :new_profile and return
    end
    @user.transaction do
      @user.build_profile(@profile.attributes)
      @user.save!
        session["devise.regist_data"]["user"].clear
        sign_in(:user, @user)
    rescue => e
      render "/devise/registrations/error"
    end
    
  end



  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    if @card.blank?
    else
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
    User.destroy_all
    # super
    
    # if @item.destroy
    #   redirect_to root_path, notice: '削除が完了しました'
    # else
    #   redirect_to root_path, alert: '削除できませんでした'
    # end

    redirect_to menu_cards_path
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected

  def profile_params
    params.require(:profile).permit(:first_name, :family_name, :first_name_kana, :family_name_kana, :birthday, :post_number, :prefecture, :city, :house_number, :phone_number, :building_name)
  end

  def set_card_payjpkey_item
    @card = Cards.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]

    # @item = Items.find_by(seller_id: current_user.id)
  end

end
