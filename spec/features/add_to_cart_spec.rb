require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true  do
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Can add products to cart" do
    # ACT
    visit root_path
    #select first product and clink on details link
    first('.product').click_on('Add')
    # verify if the product page loaded by checking css value and count 1
    expect(page).to have_content ('My Cart (1)') 
    #save screenshot
    save_screenshot
  end

end
