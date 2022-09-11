module Services
  module Wallets
    class List
      Result = Struct.new(:status, :object)

      def initialize(user)
        @user = user
      end

      def perform
        Result.new(200, user.wallets)
      end

      private

      attr_reader :user
    end
  end
end
