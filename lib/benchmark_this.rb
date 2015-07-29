# used in both Ruby and RubyMotion versions
#------------------------------------------------------------------------------
def benchmark_this
  puts
  puts "Running tests on #{Time.now.strftime("%Y-%m-%d")} under #{RUBY_DESCRIPTION}"
  puts '------------------------------------------------------------------------------'
  
  # check_upto
  # check_ord
  # check_case
  check_include
end

# based on method in "Ruby Performance Optimization"
# dont' have a reliable way of getting memory usage for an OS X app at
# the moment, so disable.
#------------------------------------------------------------------------------
def measure(prefix = '', &block)
  # GC.start
  # memory_before  = `ps -o rss= -p #{Process.pid}`.to_i/1024
  
  time = Benchmark.realtime do
    yield
  end
  
  # GC.start
  # memory_after = `ps -o rss= -p #{Process.pid}`.to_i/1024
  # puts "#{prefix}time: #{time.round(2)}, memory: #{"%d MB" % (memory_after - memory_before)}"
  puts "#{prefix}time: #{time.round(2)}"
end  

#------------------------------------------------------------------------------
def check_upto
  runs = 100000
  measure "\n-> upto @ #{runs} : " do
    x = 10000
    runs.times { 0.upto(x) {|y| y} }
  end
end

#------------------------------------------------------------------------------
def check_ord
  runs    = 100000
  string  = '1234567890' * 50
  measure "\n-> ord @ #{runs} : " do
    runs.times { 0.upto(string.length - 1) { |pos| string[pos].ord unless string[pos].nil? } }
  end    
end

#------------------------------------------------------------------------------
def check_case
  runs    = 100000
  string  = '1;3@5~7]9>' * 50
  measure "\n-> case @ #{runs} : " do
    runs.times do
      0.upto(string.length - 1) do |pos|
        case string[pos].ord
        when 0x0A,    # \n
             0x21,    # !
             0x23,    # #
             0x24,    # $
             0x25,    # %
             0x26,    # &
             0x2A,    # *
             0x2B,    # +
             0x2D,    # -
             0x3A,    # :
             0x3C,    # <
             0x3D,    # =
             0x3E,    # >
             0x40,    # @
             0x5B,    # [
             0x5C,    # \
             0x5D,    # ]
             0x5E,    # ^
             0x5F,    # _
             0x60,    # `
             0x7B,    # {
             0x7D,    # }
             0x7E     # ~
          true
        else
          false
        end
      end
    end
  end    
end

# same functionality as check_case, but uses Array.include? instead of case/when
#------------------------------------------------------------------------------
def check_include
  runs    = 100000
  string  = '1;3@5~7]9>' * 50
  chars = [0x0A,    # \n
           0x21,    # !
           0x23,    # #
           0x24,    # $
           0x25,    # %
           0x26,    # &
           0x2A,    # *
           0x2B,    # +
           0x2D,    # -
           0x3A,    # :
           0x3C,    # <
           0x3D,    # =
           0x3E,    # >
           0x40,    # @
           0x5B,    # [
           0x5C,    # \
           0x5D,    # ]
           0x5E,    # ^
           0x5F,    # _
           0x60,    # `
           0x7B,    # {
           0x7D,    # }
           0x7E     # ~
         ]
  measure "\n-> include @ #{runs} : " do
    runs.times do
      0.upto(string.length - 1) do |pos|
        chars.include?(string[pos].ord)
      end
    end
  end    
end
