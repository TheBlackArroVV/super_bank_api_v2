module Services
  module Users
    class Create
      Result = Struct.new(:status, :object)

      def initialize(params)
        @params = params
      end

      def perform
        validate!
        return Result.new(422, form.errors.to_h) unless form.errors.empty?

        user = User.create(user_params)
        Result.new(201, user)
      end

      private

      def validate!
        @form = ::UserContract.new.call(params)
      end

      attr_reader :params, :form

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
