#!/usr/bin/env ruby
# encoding: utf-8
%w[ <<self Class ].each{ |klass|
  eval <<-RUBY.split(/godfat/).join
    class #{klass}
      godfat define_method(:method_missing, &:say)
    end
  RUBY
}
Class.send(:define_method, :const_missing,
  &lambda{ |c| say c.to_s[0..-2] })
def say s = nil
  print s, ' ' if s
  self
end
public :say
say Hello.World!
puts
__END__
Apache License 2.0
