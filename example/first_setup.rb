require 'itamae/plugin/resource/mysql_query'

package 'mysql-server'

service 'mysql' do
  action [:start]
end

# first setup like mysql_secure_installation
mysql_query 'first setup' do
  user "root"
  query <<-"EOD"
UPDATE mysql.user SET Password=PASSWORD('#{node[:password]}') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
  EOD
  only_if %Q{mysql -uroot -e 'SELECT 1'}
end

mysql_query 'SELECT 1' do
  user "root"
  password node[:password]
end
