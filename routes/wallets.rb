class App
  include ParamsHelper
  include AuthenticationHelper

  hash_branch 'wallets' do |r|
    r.get do
      authenticate_user!

      result = ::Services::Wallets::List.new(current_user).perform
      response.status = result.status
      result.object.to_json
    end

    r.post do
      authenticate_user!

      result = ::Services::Wallets::Create.new(current_user, params).perform
      response.status = result.status
      result.object.to_json
    end
  end
end
