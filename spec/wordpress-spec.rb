require_relative "lib/ansible_helper"
require_relative "bootstrap"

RSpec.configure do |config|
  config.before :suite do
    AnsibleHelper.instance.playbook "playbooks/wordpress-playbook.yml"
  end
end

describe command("curl -I wordpress.dev") do
  it "redirects to wp-install.php" do
    expect(subject.stdout).to match /HTTP\/1\.1 302 Found/
    expect(subject.stdout).to match /Location: http:\/\/wordpress\.dev\/wp-admin\/install\.php/
  end
end

describe command("curl wordpress.dev/wp-admin/install.php") do
  it "is the WordPress install page" do
    expect(subject.stdout).to match /<title>WordPress &rsaquo; Installation<\/title>/
  end
end
