
default[:hue][:user] = 'hue'
default[:hue][:group] = 'hue'
#default[:hue][:hadoop_supergroup] = 'hadoop'
default[:hue][:install_dir] = '/opt/hue'

default[:hue][:host] = '0.0.0.0'
default[:hue][:port] = '8888'
default[:hue][:timezone] = 'America/Los_Angeles'

# Source
default[:hue][:repository] = 'https://github.com/cloudera/hue.git'
default[:hue][:branch] = 'master'

# Comma separated list of apps to not load at server startup.
default[:hue][:app_blacklist] = []

# YARN
default[:hue][:yarn][:resourcemanager][:host] = 'localhost'
default[:hue][:yarn][:resourcemanager][:port] = 8032

# HDFS
default[:hue][:webhdfs_url] = 'http://localhost:50070/webhdfs/v1'

# Spark
default[:hue][:spark_url] = 'http://localhost:8090/'

# Zookeeper hosts
default[:hue][:zookeeper][:host_ports] = ['localhost:2181']

# HBase
default[:hue][:hbase_servers] = [
  { name: 'Cluster', host: 'localhost', port: '9090' }
]

# Hive
default[:hue][:hive][:host] = 'localhost'
default[:hue][:hive][:port] = 10000

# SMTP
default[:hue][:smtp][:host] = 'localhost'
default[:hue][:smtp][:port] = 25
default[:hue][:smtp][:user] = ''
default[:hue][:smtp][:pass] = ''

# Share submitted jobs information with all users
default[:hue][:share_jobs] = true

# Authentication
# See hue-ini.erb
default[:hue][:auth_backend] = 'desktop.auth.backend.AllowAllBackend'

default[:hue][:dependencies] = [
  'make',
  'ant',
  'epel-release',
  'npm',
  'libtidy',
  'gcc',
  'gcc-c++',
  'libxml2-devel',
  'libxslt-devel',
  'maven',
  'python-devel',
  'asciidoc',
  'cyrus-sasl-devel',
  'cyrus-sasl-gssapi',
  'cyrus-sasl-plain',
  'krb5-devel',
  'libffi-devel',
  'mysql',
  'mysql-devel',
  'openldap-devel',
  'sqlite-devel',
  'gmp-devel',
]
