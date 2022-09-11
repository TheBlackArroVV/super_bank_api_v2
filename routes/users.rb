class App
  include ParamsHelper

  hash_branch 'users' do |r|
    r.on 'sign_up' do
      r.post do
        result = ::Services::Users::Create.new(params).perform
        response.status = result.status
        result.object.to_json
      end
    end
  end
end
