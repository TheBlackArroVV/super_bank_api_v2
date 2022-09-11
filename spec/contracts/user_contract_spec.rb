RSpec.describe ::UserContract do
  subject(:contract) { described_class.new.call(params) }

  let(:params) { { email: email, password: password, password_confirmation: password_confirmation } }
  let(:email) { 'email@email.com' }
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }

  it { expect(contract.errors.messages).to eq([]) }

  %i[email password password_confirmation].each do |param|
    context "when #{param} is empty" do
      let(param) { nil }

      it { expect(contract.errors.to_h).to eq(param => ['must be filled']) }
    end
  end

  context 'when password does not match' do
    let(:password_confirmation) { '123' }

    it { expect(contract.errors.to_h).to eq(password: ['Passwords are not the same']) }
  end

  context 'when email already used' do
    before { User.create(email: email) }

    it { expect(contract.errors.to_h).to eq(email: ['Email already in use']) }
  end
end
