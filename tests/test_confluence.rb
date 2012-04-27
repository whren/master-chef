require File.join(File.dirname(__FILE__), 'helper.rb')

class TestConfluence < Test::Unit::TestCase

  include VmTestHelper

  def test_confluence
    @vm.upload_json "confluence.json"
    @vm.run_chef
    @http.get 80, "/confluence/setup/setuplicense.action"
    @http.assert_last_response_code 200
    @http.assert_last_response_body_regex /Confluence Setup Wizard/
  end

end