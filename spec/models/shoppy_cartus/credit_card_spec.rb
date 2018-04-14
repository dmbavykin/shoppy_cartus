module ShoppyCartus
  describe CreditCard, type: :model do
    context 'validates' do
      %i[number cvv expiration_date card_name].each do |field|
        it "invalid without #{field}" do
          is_expected.to validate_presence_of(field)
        end
      end
    end

    context 'relations' do
      it 'belongs to user' do
        is_expected.to belong_to(:user)
      end

      it 'has many orders' do
        is_expected.to have_many(:orders)
      end
    end
  end
end
