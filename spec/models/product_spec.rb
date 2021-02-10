require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with name, price, quantity, and category" do
    @category = Category.new(name: "Apparel")
    @category.save
    product = @category.products.create(name: "Hazmat Suit", price: 100, quantity: 1000)
    product.save
    
    expect(product).to be_valid
  end

  it "is not valid without a name" do
    @category = Category.new(name: "Apparel")
    @category.save
    @product = @category.products.create(name: nil, price: 100, quantity: 1000)
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end

  it "is not valid without a price" do
    @category = Category.new(name: "Apparel")
    @category.save
    @product = @category.products.create(name: "Hazmat Suit", price: nil, quantity: 1000)
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end

  it "is not valid without a quantity" do
    @category = Category.new(name: "Apparel")
    @category.save
    @product = @category.products.create(name: "Hazmat Suit", price: 100, quantity: nil)
    # Alternative syntax
    expect(@product.errors.messages).to include(:quantity => ["can't be blank"])
  end

  it "is not valid without a category" do
    @product = Product.new(name: "Hazmat Suit", price: 100, quantity: 1000)
    @product.save
    expect(@product.errors.messages).to include({:category => ["can't be blank"]})
  end

end

