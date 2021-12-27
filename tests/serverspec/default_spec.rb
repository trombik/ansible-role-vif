require "spec_helper"
require "serverspec"

vifs = [
  { name: "carp0", inet: "10.0.2.100" },
  { name: "trunk0", inet: "10.1.1.100", extra_regexp: [/vether\d port master,active/, /vether\d port active/] },
  { name: "vether0", inet: false },
  { name: "vether1", inet: false }
]

vifs.each do |vif|
  describe file "/etc/hostname.#{vif[:name]}" do
    it { should exist }
    it { should be_file }
    it { should be_mode 600 }
    it { should be_owned_by "root" }
    it { should be_grouped_into "wheel" }
  end

  describe command "ifconfig #{vif[:name]}" do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/^#{vif[:name]}:\s+.*UP.*RUNNING/) }
    its(:stdout) { should match(/inet #{vif[:inet]}/) } if vif[:inet]
    if vif.key?(:extra_regexp)
      vif[:extra_regexp].each do |re|
        its(:stdout) { should match(/#{re}/) }
      end
    end
  end
end
