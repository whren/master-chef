require File.join(File.dirname(__FILE__), '..', 'helper.rb')

class TestRedmine < Test::Unit::TestCase

  include VmTestHelper

  def test_conf3
    @vm.upload_json "conf3.json"
    @vm.run_chef
    @http.get 80, "/redmine"
    @http.assert_last_response_code 200
    @http.assert_last_response_body_regex /Redmine/
  end

end