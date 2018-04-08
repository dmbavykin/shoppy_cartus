# frozen_string_literal: true

feature 'cart page' do
  let!(:product) { create(:product, quantity: 2) }
  let!(:user) { create(:user) }
  let!(:order) { create(:shoppy_cartus_order, user: user, state: 'filling') }
  let!(:empty_order) { create(:shoppy_cartus_order, state: 'filling') }

  describe 'order with items' do
    background do
      create(:shoppy_cartus_order_item, order: order)
      create(:shoppy_cartus_order_item, order: order, product: product)
      stub_current_order(order)
      visit(shoppy_cartus.order_items_path)
    end

    scenario 'check main elements' do
      expect(page).to have_selector('.hidden-xs .close.general-cart-close', count: order.order_items.count)
      order.order_items.each do |item|
        expect(page).to have_css('.hidden-xs span.font-16.in-gold-500', text: "€#{item.product.price}")
      end
      expect(page).to have_css('.btn', text: 'Checkout')
    end
  end

  scenario 'empty cart' do
    allow_any_instance_of(ShoppyCartus::ApplicationController).to receive(:current_order).and_return(empty_order)
    visit(shoppy_cartus.order_items_path)
    expect(page).to have_content(I18n.t('cart.empty'))
  end
end
