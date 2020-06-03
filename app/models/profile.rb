class Profile < ApplicationRecord
  belongs_to :user, optional: true
  validates :birthday, :post_number, :prefecture, :city, :house_number,     presence: true
  validates :first_name, :family_name, :first_name_kana, :family_name_kana, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/,message: "全角のみで入力して下さい"}


end
