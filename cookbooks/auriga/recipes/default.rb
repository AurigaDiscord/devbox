# Repos
apt_repository 'docker' do
  uri          'https://download.docker.com/linux/ubuntu'
  arch         'amd64'
  distribution 'xenial'
  components   ['stable']
  key          'https://download.docker.com/linux/ubuntu/gpg'
end

apt_repository 'postgresql' do
  uri          'http://apt.postgresql.org/pub/repos/apt/'
  arch         'amd64'
  distribution 'xenial-pgdg'
  components   ['main']
  key          'https://www.postgresql.org/media/keys/ACCC4CF8.asc'
end

apt_repository 'esl' do
  uri          'https://packages.erlang-solutions.com/ubuntu'
  arch         'amd64'
  distribution 'xenial'
  components   ['contrib']
  key          'https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc'
end

apt_repository 'packagecloud-rabbitmq' do
  uri          'https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu'
  arch         'amd64'
  distribution 'xenial'
  components   ['main']
  key          'https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey'
end


apt_package %w(docker-ce docker-compose postgresql-9.6 rabbitmq-server python3-pika) do
  action :install
end


['docker', 'postgresql', 'rabbitmq-server'].each do |s|
  service s do
    action [:enable, :start]
  end
end


group 'docker' do
  action  :modify
  members 'vagrant'
  append  true
end


execute 'rabbitmq_dev_init' do
  command 'bash /vagrant/scripts/provision/rabbitmq.sh'
end
