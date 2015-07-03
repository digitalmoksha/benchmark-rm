# -*- coding: utf-8 -*-

require 'benchmark'
require File.join(File.dirname(File.expand_path(__FILE__)), 'lib/benchmark_this.rb')

task :default => :benchmark

desc "Run benchmark"
task :benchmark do
  benchmark_this
end
