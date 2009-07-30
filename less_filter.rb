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

    register :less do |input, cursor|
      LessFilter.new(input, cursor).filter
    end

  end
end