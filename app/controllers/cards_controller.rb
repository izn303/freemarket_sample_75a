class CardsController < ApplicationController

  # require "payjp"

  # def new
  #    card = Card.where(user_id: current_user.id)
  #    redirect_to action: "show" if card.exists?
  # end

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
  end

  def pay
    # Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]

    if params['payjp-token'].blank?
      # redirect_to action: "new"
      new_card_path

    else
      customer = Payjp::Customer.create(
      # description: '登録テスト', 
      # email: current_user.email, 
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        # redirect_to action: "show"
        redirect_to card_path(current_user.id)
      else
        # redirect_to action: "pay"
        redirect_to pay_cards_path
      end
    end
  end

  def destroy #PayjpとCardデータベースを削除
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to new_card_path
  end


  def show #Cardのデータpayjpに送り情報を取り出す
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to new_card_path 
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end
