desc "Port data from an SJAA database"
task patch: [:environment] do
  require_relative('../../db/sjaa_port')
  include SjaaPort

  patch(ENV['PATCH_FILE'])
end