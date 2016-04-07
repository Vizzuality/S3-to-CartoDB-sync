server 'ec2-54-165-252-79.compute-1.amazonaws.com', user: 'ubuntu', roles: %w{web app db}, primary: true
set :ssh_options, {
  forward_agent: true
}
