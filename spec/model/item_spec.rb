require 'rails_helper'
describe Item do
  describe '#create' do
    it "商品名、価格、商品説明、商品状態、配送料の負担、発送元の地域、発送までの日数、カテゴリー、が入力されていれば出品可能" do
      user = create(:user)
      category = create(:category)
      item = FactoryBot.build(:item, seller_id: user[:id], category_id: category[:id])
      expect(item).to be_valid
    end
  end
end


