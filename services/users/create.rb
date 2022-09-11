module Services
  module Users
    class Create
      Result = Struct.new(:status, :object)

      def initialize(params)
        @params = params
      end

      def perform
        validate!
        return Result.new(422, contract.errors.to_h) unless contract.errors.empty?

        user = User.create(user_params)
        auth_token = create_auth_token(user.id)
        Result.new(201, auth_token.to_hash.except(:id, :user_id))
      end

      private

      def validate!
        @contract = ::UserContract.new.call(params)
      end

      attr_reader :params, :contract

      def user_params
        {
          name: params[:name],
          email: params[:email],
          password: params[:password]
        }
      end

      def create_auth_token(user_id)
        AuthToken.create(user_id: user_id, token: ::SecureRandom.hex(32))
      end
    end
  end
end
