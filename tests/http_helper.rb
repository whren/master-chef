
require 'net/http'
require 'uri'

class HttpTester

  include Test::Unit::Assertions

  def initialize vm
    @vm = vm
  end

  def get port, path
    @response = Net::HTTP.get_response(URI("http://#{@vm.ip}:#{port}#{path}"))
  end

  def assert_last_response_code code
    assert_equal code.to_s, @response.code
  end

  def assert_last_response_body_regex regex
    assert_match regex, @response.body
  end

end