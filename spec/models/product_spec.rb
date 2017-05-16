require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      @category = Category.new(id: 1, name: "trucks")
      @product = @category.products.new(name: "Toyota Tundra",
                                        price_cents: 55000000,
                                        quantity: 4)
    end                                 
    it "should succeed if product has all values are provided" do
      expect(@product.valid?).to be true
    end
    it "should validate presense of name" do
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "should validate presence of price" do
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "should validate presence of quantity" do
      @product.quantity = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "should validate presence of category" do
      # product = Product.new(name:"candy", price_cents: 100, quantity: 5)
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
