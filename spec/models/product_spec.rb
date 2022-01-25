require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do
    # validation tests/examples here
    it 'is a valid product' do
      @product = Product.new
      @category = Category.new

      @category.name = "test"
      @product.name = "Captain Slow's fast car"
      @product.price_cents =  125525
      @product.quantity = 15
      @product.category = @category
      expect(@product.valid?).to be true      
    end
    it 'Check name presence' do
      @product = Product.new
      @product.name = nil #should have an error message
      @product.valid? #active record check
      expect(@product.errors[:name]).to include("can't be blank")

      @product.name = "Hamster" #should not have an error message
      @product.valid?
      expect(@product.errors[:name]).not_to include("can't be blank")
    end

    it 'Check price presence' do
      @product = Product.new
      @product.price_cents = nil #should have an error
      @product.valid?
      expect(@product.errors[:price_cents]).to include ("is not a number")
      
      @product.price_cents = 15000 #should not have an error
      @product.valid?
      expect(@product.errors[:price_cents]).not_to include ("can't be blank")
    end

    it 'Check quantity presence' do 
      @product = Product.new
      @product.quantity = nil #should have an error message
      @product.valid? #active record check
      expect(@product.errors[:quantity]).to include("can't be blank")

      @product.quantity = 15 #should not have an error message
      @product.valid?
      expect(@product.errors[:quantity]).not_to include("can't be blank")
    end

    it 'Check category presence' do
      @product = Product.new
      @category = Category.new
      @product.category = nil #should have an error
      @product.valid?

      expect(@product.errors[:category]).to include ("can't be blank")

      @product.category = @category
      @product.valid?
      expect(@product.errors[:category]).not_to include ("can't be blank")
    end

  end
end
