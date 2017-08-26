# Cookbook:: momo-iis
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

dsc_script 'Web-Server' do
  code <<-EOH
  WindowsFeature InstallWebServer
  {
    Name = "Web-Server"
    Ensure = "Present"
  }
  EOH
end

dsc_script 'Web-Asp-Net45' do
  code <<-EOH
  WindowsFeature InstallDotNet45
  {
    Name = "Web-Asp-Net45"
    Ensure = "Present"
  }
  EOH
end

dsc_script 'Web-Mgmt-Console' do
  code <<-EOH
  WindowsFeature InstallIISConsole
  {
    Name = "Web-Mgmt-Console"
    Ensure = "Present"
  }
  EOH
end

include_recipe "dotnetcore::default"
include_recipe "iis::remove_default_site"

remote_directory node['momo-iis']['site-path'] do
  source 'momo-iis'
  # might need rights here
  action :create
end

iis_pool 'momo-pool' do
  runtime_version "4.0"
  action :add
end

iis_site 'momo-site' do
  protocol :http
  port 80
  path node['momo-iis']['site-path']
  application_pool 'momo-pool'
  action [:add, :start]
end
