require 'itamae/plugin/resource/mysql_query'
package 'mysql-server'

service 'mysql' do
  action [:start]
end

#mysql_query 'create database' do
#  user 'root'
#  query 'create database itamae_test'
#end

mysql_query 'test sql' do
  user 'root'
  query 'SELECT 1'
end

mysql_query 'CREATE DATABASE IF NOT EXISTS itamae_test' do
  user "root"
end
