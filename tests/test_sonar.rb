require File.join(File.dirname(__FILE__), 'helper.rb')

class TestSonar < Test::Unit::TestCase

  include VmTestHelper

  def test_sonar
    @vm.upload_json "sonar.json"
    @vm.run_chef
    @http.get 80, "/sonar/"
    @http.assert_last_response_code 200
    @http.assert_last_response_body_regex /SonarSource/
    @http.assert_last_response_body_regex /Home/
  end

end