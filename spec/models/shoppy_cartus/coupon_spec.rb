module ShoppyCartus
  describe Coupon, type: :model do
    context 'check relations' do
      it 'belongs to order' do
        is_expected.to belong_to(:order)
      end
    end

    context 'validates' do
      %i[code sale].each do |field|
        it "invalid without #{field}" do
          is_expected.to validate_presence_of(field)
        end
      end
    end
  end
end
