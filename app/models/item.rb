class Item < ApplicationRecord 
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, optional: true, class_name: 'User'
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipment_pref
  belongs_to_active_hash :item_status
  belongs_to_active_hash :shipment_fee
  belongs_to_active_hash :shipment_date
  validates :name,length: { in: 1..40 }
  validates :introduction,length: { in: 1..1000 }
  validates :price, numericality: { less_than_or_equal_to: 9999999, greater_than_or_equal_to: 300 }
  validates :category_id, :item_status, :shipment_date, :shipment_pref, presence: true
end