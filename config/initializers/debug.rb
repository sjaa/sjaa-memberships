# Debug configuration for Docker remote debugging
# Debug server is disabled by default and only enabled when running Rails server
# The debug gem automatically starts when RUBY_DEBUG_OPEN=true is set
# The Rails server uses port 1234 for debugging (set in docker compose)

# For console access (now without debug conflicts), use:
# docker container exec -it sjaa-memberships-app-1 env RUBYOPT="-W0" bin/rails console