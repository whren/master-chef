require File.join(File.dirname(__FILE__), '..', 'helper.rb')

class TestConfluence < Test::Unit::TestCase

  include VmTestHelper

  def test_conf1
    @vm.upload_json "conf1.json"
    @vm.run_chef
    # multiple run for testing chef-sol scripts
    @vm.run_chef
    @http.get 80, "/toto/setup/setuplicense.action"
    @http.assert_last_response_code 200
    @http.assert_last_response_body_regex /Confluence Setup Wizard/
    @vm.run "sudo netstat -nltp | grep 127.0.0.1:9999 | grep LISTEN | grep java"
  end

end