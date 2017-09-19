SimpleJsonApi.configure do |c|
  c.base_url = 'http://localhost:3000'
  c.logger = Rails.logger
  c.serializer_options = {
        escape_mode: :json,
        time: :xmlschema,
        mode: :compat
      }
end

# If having JSON serialization issues, uncomment this to see which JSON encoder is used. 
# https://github.com/ohler55/oj/blob/master/pages/Rails.md
# module ActiveSupport
#   module JSON
#     def self.encode(value, options = nil)
#       Rails.logger.info("IM BEING CALLED #{value} encoder class #{Encoding.json_encoder} CALLER #{caller[0,2]}")
#       Rails.logger.info("OPTIONS ARE #{options}")
#       # NOTE: oj options are passed thru but config.active_support.escape_html_entities_in_json = false seems to
#       # control escaping html entities.
#       Encoding.json_encoder.new(options).encode(value)
#     end
#   end
# end
