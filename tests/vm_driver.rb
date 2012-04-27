
SSH_CONFIG_FILE = File.join(File.dirname(__FILE__), "ssh", "config") 
SSH_KEY = File.join(File.dirname(__FILE__), "ssh", "id_rsa")
SSH_OPTS = "-F #{SSH_CONFIG_FILE} -i #{SSH_KEY}"
%x{chmod 0600 #{SSH_KEY}}
%x{rm -f /tmp/tmp_known_hosts}
    
class VmDriver

  def format_chef_ssh cmd
    "ssh #{SSH_OPTS} #{CHEF_USER}@#{ip} #{cmd}"
  end

  def run cmd
    begin
      raise "ssh #{CHEF_USER} : #{cmd} failed. Aborting..." unless system format_chef_ssh(cmd) 
    rescue
      raise "ssh #{CHEF_USER} : #{cmd} failed. Aborting..."
    end
  end

  def run_chef
    run "/etc/chef/update.sh"
  end

  def upload_json json
    json_file = File.join(File.dirname(__FILE__), "json", json)
    exec_local "scp #{SSH_OPTS} #{json_file} #{CHEF_USER}@#{ip}:/tmp/local.json"
    self.run "sudo mv /tmp/local.json /etc/chef/local.json"
  end

end
