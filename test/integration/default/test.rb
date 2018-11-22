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

describe package('zabbix-server-mysql') do
  it { should be_installed }
end

describe port('10051') do
  it { should be_listening }
end

describe mysql_session('root').query('show databases;') do
  its('stdout') { should match(/zabbix/) }
end

describe package('zabbix-web') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe port('80') do
  it { should be_listening }
end

describe http('http://localhost') do
  its('status') { should cmp 200 }
  its('title') { should match(/zabbix/) }
end
