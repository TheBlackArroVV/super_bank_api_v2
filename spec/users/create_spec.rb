RSpec.describe Services::Users::Create do
  subject(:service) { described_class.new(params) }

  describe '#perform' do
    subject(:perform) { service.perform }

    context 'when params are valid' do
      let(:params) { { email: 'email', password: 'password', password_confirmation: 'password' } }

      it { expect(perform.status).to eq(201) }
      it { expect { perform }.to change(User, :count).by(1) }
      it { expect { perform }.to change(AuthToken, :count).by(1) }
    end

    context 'when params are invalid' do
      let(:params) { { email: 'email', password: 'password' } }

      it { expect(perform.status).to eq(422) }
      it { expect(perform.object).to eq({ password_confirmation: ['is missing'] }) }
    end
  end
end
