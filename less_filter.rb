# LESS filter for Webby
# =====================
#   
# This filter allows you to use LESS syntax in your Webby files.
#   
#   * LESS extends CSS with variables, mixins, operations, and nested rules:
#     http://lesscss.org/
#
#   * Webby is a little website management system with a knack for transforming
#     text: http://webby.rubyforge.org/
#
#
# Instructions
# ------------
# To use it:
#   
#   1. Put less_filter.rb in the lib/ directory of your Webby project.
#   
#   2. Add 'less' as a filter in the files you want to run through LESS. You'll
#      probably also want to tell Webby to not add the layout to this file:
#  
#      ---
#      filter: less
#      layout: nil
#      extension: css
#      ---
#      /* Your CSS goes here */ 
#
#  
# License (The MIT License)
# -------------------------
# Copyright © 2008-2009 Jakob Skjerning <jakob@mentalized.net>
#   
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the ‘Software’), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#   
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#   
# THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

require 'less'

module Webby
  class Renderer
    attr_reader :page
  end

  module Filters

    class LessFilter
      attr_accessor :input
      def initialize(input, cursor)
        @input = input
      end

      def filter
        Less.parse(self.input)
      end
    end

    # Don't attempt to register with Webby if the script is being run directly
    unless __FILE__ == $0
      register :less do |input, cursor|
        LessFilter.new(input, cursor).filter
      end
    end
  end
end


if __FILE__ == $0
  # To run the tests, just run this file on it's own:
  #  
  #   $ ruby less_filter.rb
  #  
  # or if you need RubyGems:
  #  
  #   $ ruby -rrubygems less_filter.rb
  #  
  # The tests require Shoulda <http://www.thoughtbot.com/projects/shoulda/>
  # and Mocha <http://mocha.rubyforge.org/>
  require 'shoulda'
  require 'mocha'

  class LessFilterTest < Test::Unit::TestCase
    context "LessFilter" do
      context "as as instance" do
        setup do
          @css = 'body { color: black }'
          @filter = Webby::Filters::LessFilter.new(@css, mock('cursor'))
        end

        should "expose the input text" do
          assert_equal @css, @filter.input
        end

        context "when being called as a filter" do
          should "pass the input to Less" do
            Less.expects(:parse).with(@css).once
            @filter.filter
          end

          should "return the parsed output from Less" do
            Less.expects(:parse).with(@css).returns('output')
            assert_equal 'output', @filter.filter
          end
        end
      end 
    end
  end
end
