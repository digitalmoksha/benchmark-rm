# used in both Ruby and RubyMotion versions
#------------------------------------------------------------------------------
def benchmark_this
  puts
  puts "Running tests on #{Time.now.strftime("%Y-%m-%d")} under #{RUBY_DESCRIPTION}"
  puts '------------------------------------------------------------------------------'
  
  # check_upto
  check_ord
  # check_case
  # check_include
end

#------------------------------------------------------------------------------
def check_upto
  runs = 100000
  puts "\n---> upto @ #{runs}"
  results = Benchmark.bm do |b|
    b.report('bench') do
      x = 10000
      runs.times { 0.upto(x) {|y| y} }
    end
  end    
end

#------------------------------------------------------------------------------
def check_ord
  runs    = 100000
  string  = '1234567890' * 50
  puts "\n---> ord @ #{runs}"
  results = Benchmark.bm do |b|
    b.report('bench') do
      runs.times { 0.upto(string.length - 1) { |pos| string[pos].ord unless string[pos].nil? } }
    end
  end    
end

#------------------------------------------------------------------------------
def check_case
  runs    = 100000
  string  = '1;3@5~7]9>' * 50
  puts "\n---> case @ #{runs}"
  results = Benchmark.bm do |b|
    b.report('bench') do
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
end

# same functionality as check_case, but uses Array.include? instead of case/when
#------------------------------------------------------------------------------
def check_include
  runs    = 100000
  string  = '1;3@5~7]9>' * 50
  puts "\n---> include @ #{runs}"
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
  results = Benchmark.bm do |b|
    b.report('bench') do
      runs.times do
        0.upto(string.length - 1) do |pos|
          chars.include?(string[pos].ord)
        end
      end
    end
  end    
end
