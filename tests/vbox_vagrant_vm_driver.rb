
require 'tmpdir'

class VboxVagrantVmDriver < VmDriver

  def initialize
    template_name = get_env("TEMPLATE")
    File.open("#{directory}/Vagrantfile", "w") do |io|
      io.puts "Vagrant::Config.run do |config|"
      io.puts "config.vm.box = \"#{template_name}\""
      io.puts "config.vm.network :hostonly, \"#{ip}\""
      io.puts "end"
    end
    Dir.chdir(directory)
    exec_local "vagrant up"
  end

  def ip
    "192.168.56.187"
  end

  def destroy
    Dir.chdir(directory)
    exec_local "vagrant destroy -f"
  end

  private
    
    def directory
      dir = "/tmp/vbox_tmp"
      unless File.exists?("/tmp/vbox_tmp")
        Dir.mkdir dir
      end
      dir
    end

end

