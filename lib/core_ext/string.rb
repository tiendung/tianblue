module Deepcalm
  module CoreExtensions
    module String
      module Inflections
        def permalize(from = 'utf-8', to = 'ascii//ignore//translit', seperator = "-")
          s = self.dup
          s.sub!(/http:\/\//, '')
          s = Iconv.iconv(to, from, s).to_s
          s.gsub!(/\W+/, ' ') # all non-word chars to spaces
          s.strip!
          s.downcase!
          s.gsub!(/\ +/, seperator) # spaces to dashes
          s
        end
      end
    end
  end
end

class String #:nodoc:
  include Deepcalm::CoreExtensions::String::Inflections
end
