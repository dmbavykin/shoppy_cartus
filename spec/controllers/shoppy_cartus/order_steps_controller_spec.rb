module ShoppyCartus
  describe OrderStepsController, type: :controller do
    routes { ShoppyCartus::Engine.routes }

    let!(:user) { create(:user) }
    let!(:product) { create(:product) }
    let!(:order) { create(:shoppy_cartus_order, user: user, state: 'filling') }
    let!(:order_item) { create(:shoppy_cartus_order_item, order: order, product: product) }

    before { allow(controller).to receive(:current_user).and_return(user) }


    describe 'GET #index' do
      context 'successful load' do
        it 'has a 302 status code by wicked' do
          get :index, session: { order_id: order.id }
          expect(response.status).to eq(302)
        end

        it 'calls needful method' do
          expect(controller).to receive(:redirect_to_step).with(:address).and_call_original
          get :index, session: { order_id: order.id }
        end
      end
    end

    describe 'GET #show' do
      context 'with correct step' do
        before { allow(controller).to receive(:wrong_step?) }

        it 'checks step' do
          expect(controller).to receive(:wrong_step?)
          get :show, params: { id: :address }, session: { order_id: order.id }
        end

        context 'render needful step' do
          %i[address delivery payment confirm complete].each do |step|
            it "renders #{step} and has status 200" do
              get :show, params: { id: step }, session: { order_id: order.id }
              expect(response.status).to eq(200)
              expect(response).to render_template(step)
            end
          end
        end

        it 'calls render_wizard method' do
          expect(controller).to receive(:render_wizard).and_call_original
          get :show, params: { id: :address }, session: { order_id: order.id }
        end

        it 'kills order_id from session' do
          allow(controller).to receive(:step).and_return(:complete)
          get :show, params: { id: :address }, session: { order_id: order.id }
          expect(session[:order_id]).to be_nil
        end
      end

      context 'with wrong step' do
        it 'calls redirect' do
          allow(controller).to receive(:wrong_step?).and_return(true)
          get :show, params: { id: :address }, session: { order_id: order.id }
          needful_step = controller.instance_variable_get(:@needful_step)
          expect(controller).to receive(:redirect_to_step).with(needful_step)
          get :show, params: { id: :address }, session: { order_id: order.id }
        end
      end
    end

    describe '#check_order' do
      it 'redirects to root' do
        new_order = create(:shoppy_cartus_order, state: 'filling')
        get :index, session: { order_id: new_order.id }
        expect(response).to redirect_to(order_items_path)
        expect(flash[:alert]).to eq I18n.t('cart.empty')
      end
    end

    describe '#set_form' do
      it 'is instance of orde steps form' do
        controller.instance_variable_set(:@order, order)
        controller.send(:set_form)
        expect(controller.instance_variable_get(:@form)).to be_kind_of(OrderStepsForm)
      end
    end

    describe '#set_needful_step' do
      it 'calls needful method' do
        controller.instance_variable_set(:@order, order)
        controller.send(:set_form)
        expect(controller.instance_variable_get(:@form)).to receive(:get_step)
        controller.send(:set_needful_step)
      end
    end
  end
end
