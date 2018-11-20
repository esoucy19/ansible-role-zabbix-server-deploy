require 'inspec'

describe file('/etc/hosts') do
  it { should exist }
end

describe package('MariaDB-server') do
  it { should be_installed }
  its('version') { (should cmp >= '10.2.7') || (should cmp >= '10.1.23') }
end

describe service('mariadb') do
  it { should be_enabled }
  it { should be_running }
end
