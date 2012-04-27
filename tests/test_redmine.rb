require File.join(File.dirname(__FILE__), 'helper.rb')

class TestRedmine < Test::Unit::TestCase

  include VmTestHelper

  def test_redmine
    @vm.upload_json "redmine.json"
    @vm.run_chef
  end

end