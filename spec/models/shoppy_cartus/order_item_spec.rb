module ShoppyCartus
  RSpec.describe OrderItem, type: :model do
    context 'check relations' do
      %i[order product].each do |field|
        it "belongs to #{field}" do
          is_expected.to belong_to(field)
        end
      end
    end
  end
end
