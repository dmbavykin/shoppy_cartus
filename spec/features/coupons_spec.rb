# frozen_string_literal: true

feature 'cart coupons' do
  let!(:product) { create(:product) }
  let!(:user) { create(:user) }
  let!(:order) { create(:shoppy_cartus_order, user: user, state: 'filling') }
  let!(:order_item) { create(:shoppy_cartus_order_item, order: order) }
  let!(:coupon) { create(:shoppy_cartus_coupon, :without_order) }

  background do
    stub_current_order(order)
    visit shoppy_cartus.order_items_path
  end

  scenario 'adding coupon successful' do
    fill_in('coupon_code', with: coupon.code)
    click_button('coupon-code-btn')
    expect(page).to have_css('.alert-success', text: I18n.t('coupon.added'))
    expect(page).to have_content("€#{coupon.sale}")
  end

  scenario 'removing coupon successful' do
    coupon.update(order: order)
    visit shoppy_cartus.order_items_path
    click_link('coupon-code-btn')
    expect(page).to have_css('.alert-success', text: I18n.t('coupon.removed'))
  end
end
