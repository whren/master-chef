require File.join(File.dirname(__FILE__), 'helper.rb')

class Testnexus < Test::Unit::TestCase

  include VmTestHelper

  def test_nexus
    @vm.upload_json "nexus.json"
    @vm.run_chef
    @http.get 80, "/nexus/index.html#welcome"
    @http.assert_last_response_code 200
    @http.assert_last_response_body_regex /Nexus/
  end

end