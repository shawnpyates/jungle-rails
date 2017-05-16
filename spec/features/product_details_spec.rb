require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'
    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "they see details of a product after clicking on Detail button" do
    visit "/"
    first('article.product').find_link('Details').click
    expect(page).to have_css ".product-detail"
  end
  scenario "they see details of a product after clicking on its image" do
    visit "/"
    first('article.product').find('img').click
    expect(page).to have_css ".product-detail"
  end
  scenario "they see details of a product after clicking on its name" do
    visit "/"
    first('article.product').find('h4').click
    expect(page).to have_css ".product-detail"
  end    
end
