module ParamsHelper
  def params
    @_params ||= (JSON.parse(@_request.body.read).merge(@_request.params)).transform_keys(&:to_sym)
  rescue JSON::ParserError
    @_request.params.transform_keys(&:to_sym)
  end
end
