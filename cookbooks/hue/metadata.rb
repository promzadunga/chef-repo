name             'hue'
maintainer       'Avaus Consulting'
maintainer_email 'erno.aapa@avaus.fi'
license          'All rights reserved'
description      'Installs/Configures hue'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ centos }.each do |os|
  supports os
end

# Cookbook dependencies
%w{ yum java git maven}.each do |cb|
  depends cb
end
