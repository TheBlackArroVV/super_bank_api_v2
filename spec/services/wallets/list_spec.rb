RSpec.describe Services::Wallets::List do
  subject(:service) { described_class.new(user) }

  describe '#perform' do
    subject(:perform) { service.perform }

    let(:user) { User.create }

    before do
      Wallet.create(user: user, currency_id: 1, amount: 100, name: 'test wallet')
    end

    it 'returns list of wallets' do
      expect(perform.status).to eq(200)
      expect(perform.object.map(&:to_hash)).to eq([{ id: 1, currency_id: 1, user_id: user.id, name: 'test wallet',
                                                     amount: 100 }])
    end
  end
end
