require 'rails_helper'

describe CardsController do
  xdescribe 'CardsController test' do
    let(:user) { create(:user) }
    let(:card) { create(:card, user_id: user.id) }
    before do
      login user
    end

    it "showアクションのページに遷移するか" do
      allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.prepare_customer_information)
      product = create(:product)
      get :show, params: { id: product,card: card}
      expect(response).to render_template :show
    end
  end

end