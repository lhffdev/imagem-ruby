begin
  require "pry"
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end

require "awesome_print"
AwesomePrint.irb!.irbrc