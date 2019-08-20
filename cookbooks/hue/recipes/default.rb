#
# Cookbook Name:: hue
# Recipe:: default
#
# Copyright 2019, Zyelabs
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'yum'
include_recipe 'java'
include_recipe 'git'

group node[:hue][:group] do
  action :create
end

user node[:hue][:user] do
  gid node[:hue][:group]
  shell '/bin/bash'
  manage_home true
  home '/home/hue'
end

=begin
#Add hive user to hadoop supergroup so that hive user can use hdfs
group node[:hue][:hadoop_supergroup] do
  action :modify
  members node[:hue][:user]
  append true
end
=end
node[:hue][:dependencies].each do |dependency|
  package dependency
end

# Got strange error without this
# Error and more info here: https://groups.google.com/a/cloudera.org/forum/#!topic/hue-user/SpXbO9OFvJ4
link '/usr/lib/python2.7/_sysconfigdata_nd.py' do
  to '/usr/lib/python2.7/plat-x86_64-linux-gnu/_sysconfigdata_nd.py'
end

directory node[:hue][:install_dir] do
  owner node[:hue][:user]
  group node[:hue][:group]
end

git node[:hue][:install_dir] do
  user node[:hue][:user]
  repository node[:hue][:repository]
  reference node[:hue][:branch]
  action :sync
  #notifies :run, 'bash[make hue]', :immediately
end

bash 'make hue' do
  cwd node[:hue][:install_dir]
  user 'root'
  code <<-EOH
    . /etc/profile
   make apps
  EOH
  not_if { ::File.exists?("#{node[:hue][:install_dir]}/build") }
end

file "#{node[:hue][:install_dir]}/desktop/conf/pseudo-distributed.ini" do
  action :delete
end

template "hue.ini" do
  path "#{node[:hue][:install_dir]}/desktop/conf/hue.ini"
  owner node[:hue][:user]
  group node[:hue][:group]
  source 'hue-ini.erb'
end

template '/etc/init.d/hue' do
  mode '0755'
  source 'initd-script.erb'
end

service "hue" do
  #supports :status => true, :restart => true
  action :enable
  subscribes :reload, "template[hue.ini]", :delayed
  subscribes :reload, "template[/etc/init.d/hue]", :delayed
end
