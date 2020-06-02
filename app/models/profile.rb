class Profile < ApplicationRecord
  belongs_to :user, optional: true
  validates :birthday, :post_number, :prefecture, :city, :house_number,     presence: true
  validates :first_name, :family_name, :first_name_kana, :family_name_kana, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/,message: "全角のみで入力して下さい"}


  # 下記は単体テストで使用するため残してください
  FactoryBot.define do

    factory :profile do
      phone_number              {"08022228888"}
      first_name                {"小原"}
      family_name               {"麻理"}
      first_name_kana           {"おはら"}
      family_name_kana          {"まり"}
      birthday                  {"20000613"}
      post_number               {"1112222"}
      prefecture                {"静岡県"}
      city                      {"沼津市"}
      house_number              {"内浦"}
      building_name             {"123"}
    end
  end

end
