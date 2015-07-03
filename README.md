# benchmark-rm

Runs some specific code benchmarks between RubyMotion and regular Ruby

To use, 

1. edit `lib/benchmark_this.rb` to enable the exact test you want to run (due to certain memory issues at the moment, it's not advisable to enable them all at the same time).
2. run `rake` to run the pure ruby test
3. `cd` to `rubymotion` and run `bundle install`, then `rake` to run the RubyMotion version