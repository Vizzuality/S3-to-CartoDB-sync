server 'ec2-52-23-207-148.compute-1.amazonaws.com', user: 'ubuntu', roles: %w{web app db}, primary: true
set :ssh_options, {
  forward_agent: true
}
