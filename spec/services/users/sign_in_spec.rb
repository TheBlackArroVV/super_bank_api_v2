RSpec.describe Services::Users::SignIn do
  subject(:service) { described_class.new(params) }

  describe '#perform' do
    subject(:perform) { service.perform }

    let!(:user) { User.create(email: 'email', password: 'Password') }
    let(:params) { { email: 'email', password: 'Password' } }

    it { expect(perform.status).to eq(201) }
    it { expect { perform }.to change(AuthToken, :count).by(1) }

    %w[email password].each do |attribute|
      context "when #{attribute} is missing" do
        let(:params) { { email: 'email', password: 'Password' }.merge!(attribute.to_sym => '') }

        it { expect(perform.status).to eq(404) }
        it { expect(perform.object).to eq({ user: ['not found'] }) }
      end
    end

    context 'when auth token already exists' do
      before { AuthToken.create(user_id: user.id, token: 'token') }

      it { expect(perform.status).to eq(201) }
      it { expect { perform }.not_to change(AuthToken, :count) }
    end
  end
end
