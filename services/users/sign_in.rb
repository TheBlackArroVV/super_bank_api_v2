module Services
  module Users
    class SignIn
      Result = Struct.new(:status, :object)

      def initialize(params)
        @params = params
      end

      def perform
        user = find_user
        return Result.new(404, { user: ['not found'] }) unless user

        destroy_old_token
        create_token
      end

      private

      attr_reader :params, :result, :user

      def find_user
        @user = ::User.find(params.slice(:email))
        return true if @user&.password == params[:password]

        @user = nil
      end

      def destroy_old_token
        ::AuthToken.find(user_id: @user.id.to_s)&.delete
      end

      def create_token
        token = ::AuthToken.create(user_id: @user.id.to_s, token: ::SecureRandom.hex(32))
        @result = Result.new(201, token.to_hash.except(:id, :user_id))
      end
    end
  end
end
