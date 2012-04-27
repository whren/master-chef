require File.join(File.dirname(__FILE__), 'helper.rb')

class TestRedmine < Test::Unit::TestCase

  include VmTestHelper

  def test_redmine
    @vm.upload_json "redmine.json"
    @vm.run_chef
    @http.get 80, "/redmine"
    @http.assert_last_response_code 200
    @http.assert_last_response_body_regex /Redmine/
  end

end