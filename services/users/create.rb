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
        Result.new(201, user)
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
    end
  end
end
