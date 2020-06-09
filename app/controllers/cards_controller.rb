class CardsController < ApplicationController

  require "payjp"
  before_action :set_item, only: [:purchase, :buy]
  before_action :set_card, only: [:new, :delete, :show, :pay, :purchase, :buy]
  before_action :payjp_key,only:   [:delete, :show, :pay, :purchase, :buy]

  def new
    if @card.present?
      redirect_to cards_path
    end
  end


  def delete
    if @card.blank?
    else
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      flash[:alert] = 'カード情報を削除しました。'
    end
      redirect_to root_path
  end

  

  def show
    if @card.blank?
      redirect_to new_card_path 
    else
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)
    end
  end


  def pay   # クレジットカード登録
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Cards.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to root_path
      else
        redirect_to new_card_path
        flash[:alert] = '登録に失敗しました。'
      end
    end
  end


  def purchase  # 購入確認画面へ遷移
    if @card.blank?
      redirect_to new_card_path
      flash[:alert] = 'カードが登録されていません'
    else
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end


  def buy #購入処理
    if @card.blank?
      flash[:alert] = '購入にはクレジットカード登録が必要です'
      redirect_to new_card_path
    else
      Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy', 
      )
      if @item.update(buyer_id: current_user.id)
        redirect_to done_item_cards_path(@item.id)
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: "items", action: 'show'
      end

    end
  end


  
    private

  def set_card
    @card = Cards.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def payjp_key
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
  end


end
