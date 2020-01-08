# frozen_string_literal: true

Dir.glob(File.join(File.dirname(__FILE__), "extra_validators", "*.rb")).sort.each do |file|
  require file
end
