require File.join(File.dirname(__FILE__), '..', 'helper.rb')

class TestJenkins < Test::Unit::TestCase

  include VmTestHelper

  def test_conf2
    @vm.upload_json "conf2.json"
    @vm.run_chef
    ok = false
    (1..20).each do |k|
      @http.get 80, "/jenkins/"
      if @http.response.code == "200" && @http.response.body =~ /New Job/
        ok = true
        break
      end
      puts "Waiting jenkins init"
      sleep 2      
    end
    assert_true ok
    @vm.run "sudo netstat -nltp | grep 127.0.0.1:9999 | grep LISTEN | grep java"
  end

end