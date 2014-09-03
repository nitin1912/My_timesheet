# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.
set :stage, :production

set :rvm_ruby_version, '1.9.2-p330'      # Defaults to: 'default'

role :app, %w{10.1.2.124}
role :web, %w{10.1.2.124}
role :db,  %w{10.1.2.124}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '10.1.2.124', user: 'qualtech_ror', roles: %w{web app}, password: 'pass@123'


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server '10.1.2.124',
  # user: 'qualtech_ror',
  # roles: %w{web app},
  # ssh_options: {
    # user: 'qualtech_ror', # overrides user setting above
    # keys: %w(/home/qualtech_ror/.ssh/id_rsa),
    # forward_agent: false,
    # auth_methods: %w(publickey password),
    # password: 'pass@123'
  # }
