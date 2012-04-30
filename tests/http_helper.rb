
require 'net/http'
require 'uri'

class HttpTester

  include Test::Unit::Assertions

  def initialize vm
    @vm = vm
  end

  def get port, path
    uri = URI.parse "http://#{@vm.ip}:#{port}#{path}"
    @response = Net::HTTP.get_response(uri)
  end

  def assert_last_response_code code
    assert_equal code.to_s, @response.code
  end

  def assert_last_response_body_regex regex
    assert_match regex, @response.body
  end

  def assert_last_response_body_not_regex regex
    assert_not_match regex, @response.body
  end

  def response
    @response
  end

end