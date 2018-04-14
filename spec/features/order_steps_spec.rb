module ShoppyCartus
  feature 'checkout page' do
    let!(:product) { create(:product, quantity: 2) }
    let!(:user) { create(:user) }
    let!(:order) { create(:shoppy_cartus_order, user: user, state: 'filling') }
    let!(:delivery) { create(:shoppy_cartus_delivery) }
    let!(:credit_card) { create(:shoppy_cartus_credit_card, user: user) }

    background do
      create(:shoppy_cartus_order_item, order: order)
      create(:shoppy_cartus_order_item, order: order, product: product)
      stub_current_user(user)
      visit(shoppy_cartus.order_steps_path)
    end

    context 'addresses' do
      scenario 'check main elements on addresses page' do
        expect(page).to have_css('.general-title-margin', text: 'Checkout')
        expect(page).to have_css('.checkbox-text', text: 'Use Billing Adress')
        expect(page).to have_selector('#addresses-submit-btn')
        expect(page).to have_selector('#addresses_form')
      end

      scenario 'filling addresses' do
        fill_address(:billing, build(:shoppy_cartus_address))
        fill_address(:shipping, build(:shoppy_cartus_address))
        click_button('addresses-submit-btn')
        expect(page).to have_css('.general-subtitle', text: 'Delivery')
      end
    end

    context 'delivery' do
      background do
        order.addresses.billing.create(attributes_for(:shoppy_cartus_address).stringify_keys)
        order.addresses.shipping.create(attributes_for(:shoppy_cartus_address).stringify_keys)
        visit shoppy_cartus.order_step_path(:delivery)
      end

      scenario 'check main elements on delivery page' do
        expect(page).to have_css('.general-subtitle', text: 'Delivery')
        expect(page).to have_css('.radio-text', text: delivery.title)
        expect(page).to have_css('span', text: delivery.days)
        expect(page).to have_css('span', text: delivery.price)
        expect(page).to have_css('#deliveries-submit-btn')
      end

      scenario 'choosing delivery method' do
        first('.hidden-xs .radio-label').click
        click_button('deliveries-submit-btn')
        expect(page).to have_css('.general-subtitle', text: 'Credit Card')
      end
    end

    context 'payment' do
      background do
        order.addresses.billing.create(attributes_for(:shoppy_cartus_address).stringify_keys)
        order.addresses.shipping.create(attributes_for(:shoppy_cartus_address).stringify_keys)
        order.update(delivery: delivery)
        visit shoppy_cartus.order_step_path(:payment)
      end

      scenario 'check main elements on payment page' do
        expect(page).to have_css('.general-subtitle', text: 'Credit Card')
        expect(page).to have_selector('input.form-control', count: 4)
        expect(page).to have_css('#payment-submit-btn')
      end

      scenario 'filling payment' do
        fill_card(attributes_for(:shoppy_cartus_credit_card))
        click_button('payment-submit-btn')
        ['Billing Address', 'Shipping Address', 'Shipments', 'Payment Information'].each do |content|
          expect(page).to have_content(content)
        end
      end
    end

    context 'confirm' do
      background do
        order.addresses.billing.create(attributes_for(:shoppy_cartus_address).stringify_keys)
        order.addresses.shipping.create(attributes_for(:shoppy_cartus_address).stringify_keys)
        order.update(delivery: delivery)
        order.update(credit_card: credit_card)
        visit shoppy_cartus.order_step_path(:confirm)
      end

      scenario 'check main elements on payment page' do
        ['Billing Address', 'Shipping Address', 'Shipments', 'Payment Information'].each do |content|
          expect(page).to have_content(content)
        end
      end

      scenario 'check order items presence' do
        order.order_items.each do |item|
          expect(page).to have_css('span', text: item.quantity)
          expect(page).to have_css('.title', text: item.product.title)
        end
      end

      scenario 'check addresses presence ' do
        order.addresses.each do |address|
          expect(page).to have_content("#{address.first_name} #{address.last_name}")
          expect(page).to have_content(address.address)
          expect(page).to have_content("#{address.city} #{address.zip}")
          expect(page).to have_content(address.country)
          expect(page).to have_content("Phone #{address.phone}")
        end
      end

      scenario 'confirming' do
        click_link('confirm-submit-btn')
        expect(page).to have_css('.general-subtitle', text: 'Thank You for your Order!')
      end
    end
  end
end
