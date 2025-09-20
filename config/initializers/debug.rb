# Debug configuration for Docker remote debugging
# The debug gem automatically starts when RUBY_DEBUG_OPEN=true is set
# The Rails server uses port 1234 for debugging (set in docker compose)

# For console access without debug server port conflicts and rdoc warnings, use:
# docker container exec -it sjaa-memberships-app-1 env RUBY_DEBUG_PORT=9999 RUBYOPT="-W0" bin/rails console