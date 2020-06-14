class Image < ApplicationRecord
  belongs_to :item, optional: true
  mount_uploader :url, ImageUploader
  validates :url, presence: true
end
 
  