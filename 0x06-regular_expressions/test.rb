#!/usr/bin/env ruby

the = ARGV[0].scan(/the/)
school = ARGV[0].scan(/school/)
puts [the, school].join(' ')
