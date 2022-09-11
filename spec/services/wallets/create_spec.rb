RSpec.describe Services::Wallets::Create do
  subject(:service) { described_class.new(user, params) }

  describe '#perform' do
    subject(:perform) { service.perform }

    let(:user) { User.create }

    context 'when params are valid' do
      let(:params) { { name: 'name', amount: 100, currency_id: 1, user_id: user.id } }

      it { expect(perform.status).to eq(201) }
      it { expect { perform }.to change(Wallet, :count).by(1) }
    end

    context 'when params are invalid' do
      let(:params) { { name: 'name', currency_id: 1, user_id: user.id } }

      it { expect(perform.status).to eq(422) }
      it { expect(perform.object).to eq({ amount: ['is missing'] }) }
    end
  end
end
