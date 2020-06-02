class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"

  validates :nickname, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true
  has_one :profile


  # 下記は単体テストで使用するため残してください
  FactoryBot.define do
    factory :user do
      nickname              {"ohara"}
      email                 {"aaa@gmail.com"}
      password              {"1111111"}
      password_confirmation {"1111111"}
    end
  end

end
