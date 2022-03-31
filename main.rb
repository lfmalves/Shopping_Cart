require 'minitest/autorun'

module Purchase
  def self.shopping_cart(products, quantities)
    occurences = products.tally

    quantities.each do |product,info|
      info[:quantity] = occurences[product.to_s]
    end

    quantities.values.select { |description| description[:quantity] != nil}
  end
end

describe Purchase do
  describe "#shopping_cart" do 
    it 'returns a filled shopping cart with correct data' do 
      products = ["CVCD", "SDFD", "DDDF", "SDFD"]
      quantities = {"CVCD": {"version": 1,"edition": "X"},"SDFD": {"version": 2,"edition":"Z"},"DDDF": {"version": 1}}

      assert Purchase.shopping_cart(products, quantities) == [{:version=>1, :edition=>"X", :quantity=>1}, {:version=>2, :edition=>"Z", :quantity=>2}, {:version=>1, :quantity=>1}]
    end
    it 'returns a filled shopping cart with purged products if not on list of products' do 
      products = ["CVCD", "SDFD", "DDDF", "SDFD"]
      quantities = {"CVCD": {"version": 1,"edition": "X"},"SDFD": {"version": 2,"edition":"Z"},"DDDF": {"version": 1}, "TEST": {"version": 1,"edition": "X"}, "LINZ": {"version": 1,"edition": "X"}}

      assert Purchase.shopping_cart(products, quantities) == [{:version=>1, :edition=>"X", :quantity=>1}, {:version=>2, :edition=>"Z", :quantity=>2}, {:version=>1, :quantity=>1}]
    end
    it 'returns an empty shopping cart with blank products list' do 
      products = []
      quantities = {"CVCD": {"version": 1,"edition": "X"},"SDFD": {"version": 2,"edition":"Z"},"DDDF": {"version": 1}, "TESTE": {"version": 1,"edition": "X"}}

      assert Purchase.shopping_cart(products, quantities) == []
    end
    it 'returns an empty shopping cart with blank quantities hash' do 
      products = ["CVCD", "SDFD", "DDDF", "SDFD"]
      quantities = {}

      assert Purchase.shopping_cart(products, quantities) == []
    end
  end
end