RSpec.describe WalletContract do
  subject(:contract) { described_class.new.call(params) }

  let(:user) { User.create }
  let(:params) { { name: name, amount: amount, currency_id: 1, user_id: user.id } }
  let(:name) { 'name' }
  let(:amount) { 100 }

  it { expect(contract.errors.messages).to eq([]) }

  %i[name amount].each do |param|
    context "when #{param} is empty" do
      let(param) { nil }

      it { expect(contract.errors.to_h).to eq(param => ['must be filled']) }
    end
  end
end
