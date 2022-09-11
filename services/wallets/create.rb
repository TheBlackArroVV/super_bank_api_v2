module Services
  module Wallets
    class Create
      Result = Struct.new(:status, :object)

      def initialize(user, params)
        @user = user
        @params = params
      end

      def perform
        validate!
        return Result.new(422, contract.errors.to_h) unless contract.errors.empty?

        wallet = Wallet.create(wallet_params)
        Result.new(201, wallet)
      end

      private

      attr_reader :user, :params, :contract

      def validate!
        @contract = ::WalletContract.new.call(params)
      end

      def wallet_params
        {
          name: params[:name],
          amount: params[:amount],
          currency_id: params[:currency_id],
          user_id: params[:user_id]
        }
      end
    end
  end
end
