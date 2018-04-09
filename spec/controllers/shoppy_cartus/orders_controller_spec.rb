module ShoppyCartus
  describe OrdersController, type: :controller do
    routes { ShoppyCartus::Engine.routes }

    let(:user) { create(:user) }
    let!(:order) { create(:shoppy_cartus_order, user: user, state: 'completed') }

    before { allow(controller).to receive(:current_user).and_return(user) }

    describe 'GET #index' do
      context 'successful load' do
        before do
          get :index, session: { order_id: order.id }
        end

        it 'assigns @items' do
          expect(assigns(:orders)).not_to be_nil
        end

        it 'renders :index template' do
          expect(response).to render_template(:index)
        end

        it 'has a 200 status code' do
          expect(response.status).to eq(200)
        end
      end

      context 'select needful orders' do
        it 'selects user orders' do
          expect(controller).to receive_message_chain(:current_user, :orders, :executed)
          get :index, session: { order_id: order.id }
        end
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: order.id }, session: { order_id: order.id, user_id: user.id } }

      it 'assigns @items' do
        expect(assigns(:_order)).not_to be_nil
      end

      it 'renders :index template' do
        expect(response).to render_template(:show)
      end

      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      context 'calling needed methods' do
        after { get :show, params: { id: order.id }, session: { order_id: order.id } }
        it 'finds needed order' do
          expect(Order).to receive(:find_by).with(id: order.id.to_s).and_call_original
        end

        it 'calls chain methods' do
          expect(Order).to receive_message_chain(:find_by, :decorate)
        end
      end
    end
  end
end
