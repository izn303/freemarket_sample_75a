class Cards < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
