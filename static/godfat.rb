#!/usr/bin/env ruby
# encoding: utf-8
%w[ Class <<self Symbol ].each{ |klass|
  eval <<-RUBY.split(/真常/).join
    class #{klass}
      真常 define_method(:method_missing, &:say)
    end
  RUBY
}
Class.send(:define_method, :const_missing,
  &lambda{ |c| cry c.to_s[0..-2] })
def say s = nil
  print s, ' ' if s
  self
end
public :say
sing Hello.World!
puts
__END__
Apache License 2.0
