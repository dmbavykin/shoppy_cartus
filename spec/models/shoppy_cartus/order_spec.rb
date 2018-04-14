module ShoppyCartus
  describe Order, type: :model do
    context 'validates' do
      it 'invalid without state' do
        is_expected.to validate_presence_of(:state)
      end
    end

    context 'check relations' do
      %i[user credit_card delivery].each do |field|
        it "belongs to #{field}" do
          is_expected.to belong_to(field)
        end
      end

      %i[addresses order_items].each do |field|
        it "has many #{field}" do
          is_expected.to have_many(field)
        end
      end

      it 'has one coupon' do
        is_expected.to have_one(:coupon)
      end
    end
  end
end
