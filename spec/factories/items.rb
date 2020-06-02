FactoryBot.define do

  factory :item do
    name              {"商品名"}
    price             {10000}
    introduction      {"商品説明"}
    item_status_id    {1}
    shipment_fee_id   {1}
    shipment_date_id  {1}
    shipment_pref_id  {1}
    category_id       {100}
    seller_id         {1}
  end

  factory :category do  
    name              {"おもちゃ"}
  end

end