#
# Cookbook Name:: datadog
# Recipe:: default
#
# Copyright 2015, bageljp
#
# All rights reserved - Do Not Redistribute
#

bash "install dd-agent" do
  user "root"
  group "root"
  code <<-EOC
    bash -c "$(curl -L #{node['datadog']['url']})"
  EOC
  environment "DD_API_KEY" => "#{node['datadog']['api_key']}"
  not_if "rpm -q dadadog-agent"
end

service "datadog-agent" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

