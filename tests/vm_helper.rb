
def exec_local cmd
  begin
    raise "#{cmd} failed. Aborting..." unless system cmd
  rescue
    raise "#{cmd} failed. Aborting..."
  end
end

def get_env name
  abort "Please specify #{name} variable" unless ENV[name]
  ENV[name]
end

class VmDriver

  def format_root_ssh cmd
    "ssh -o StrictHostKeyChecking=no root@#{ip} #{cmd}"
  end

  def run_root cmd
    begin
      raise "ssh root : #{cmd} failed. Aborting..." unless system format_root_ssh(cmd) 
    rescue
      raise "ssh root : #{cmd} failed. Aborting..."
    end
  end

end

def upload_local_json name
  ip = get_env("IP")
  file = File.join(File.dirname(__FILE__), 'local_json',  "#{name}.json")
  exec_local "scp #{file} chef@#{ip}:/tmp/"
  exec_local "ssh chef@#{ip} sudo mv /tmp/#{name}.json /etc/chef/local.json"
end

def run_chef

end

test_dir = File.dirname(__FILE__)
Dir["#{test_dir}/*vm_driver.rb"].each do |f|
  require f
end

vm_driver = "#{get_env "VM_DRIVER"}VmDriver"
puts "Using VM_DRIVER #{vm_driver}"
abort "VM_DRIVER not found #{vm_driver}" unless Object.const_defined? vm_driver
VM_DRIVER_CLAZZ = Kernel.const_get vm_driver
