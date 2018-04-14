module ShoppyCartus
  describe CouponsController, type: :controller do
    routes { ShoppyCartus::Engine.routes }

    let!(:user) { create(:user) }
    let!(:order) { create(:shoppy_cartus_order, user: user) }
    let!(:coupon) { create(:shoppy_cartus_coupon, order: order) }
    let(:unused_coupon) { create(:shoppy_cartus_coupon, :without_order) }
    let(:invalid_coupon) { attributes_for(:shoppy_cartus_coupon, :invalid).stringify_keys }

    before { allow(controller).to receive(:current_user).and_return(user) }

    describe 'POST #create' do
      context 'coupon does not exist' do
        before { post :create, params: { coupon: invalid_coupon } }

        it 'redirects to cart page' do
          expect(response).to redirect_to(order_items_path)
        end

        it 'sends alert' do
          expect(flash[:alert]).to eq I18n.t('coupon.not_exist')
        end
      end

      context 'coupon used' do
        before { post :create, params: { coupon: { code: coupon.code } } }

        it 'redirects to cart page' do
          expect(response).to redirect_to(order_items_path)
        end

        it 'sends alert' do
          expect(flash[:alert]).to eq I18n.t('coupon.used')
        end
      end

      context 'with valid params' do
        before { post :create, params: { coupon: { code: unused_coupon.code } } }

        it 'relates coupon with order' do
          expect(Coupon.find(unused_coupon.id).order).not_to be_nil
        end

        it 'redirects to cart page' do
          expect(response).to redirect_to(order_items_path)
        end

        it 'sends notice' do
          expect(flash[:notice]).to eq I18n.t('coupon.added')
        end
      end
    end

    describe 'DELETE #destroy' do
      before { delete :destroy, params: { id: coupon.id } }

      it 'relates coupon with order' do
        expect(Coupon.find(coupon.id).order).to be_nil
      end

      it 'redirects to cart page' do
        expect(response).to redirect_to(order_items_path)
      end

      it 'sends notice' do
        expect(flash[:notice]).to eq I18n.t('coupon.removed')
      end
    end
  end
end
