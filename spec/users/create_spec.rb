RSpec.describe Services::Users::Create do
  subject(:service) { described_class.new(params) }

  describe '#perform' do
    subject(:perform) { service.perform }

    context 'when params are valid' do
      let(:params) { { email: 'email', password: 'password', password_confirmation: 'password' } }

      it { expect(perform.status).to eq(201) }
    end

    context 'when params are invalid' do
      let(:params) { { email: 'email', password: 'password' } }

      it { expect(perform.status).to eq(422) }
      it { expect(perform.object).to eq({ email: ['Email already in use'], password_confirmation: ['is missing'] }) }
    end
  end
end
