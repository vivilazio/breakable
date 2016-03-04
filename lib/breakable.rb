require "breakable/version"
require 'active_support/concern'
require 'active_record'

module Breakable
  class ActiveRecord::Base
    def self.is_breakable bdy
      #if body
      # TODO
        class << self; attr_accessor :bdy end
        @bdy = bdy
        def full_text
          @full_text ||= method(self.bdy).call
        end
      #end
      include Breakable
    end
  end
  module Breakable
    extend ActiveSupport::Concern
    STOP = "<!--break-->".freeze

    included do
      def small_text
        @small_text ||= introduction(300)
      end

      def medium_text
        @medium_text ||= introduction(500)
      end

      protected
      def introduction length
        textArr = ""
        if !self.full_text.blank?
          textArr = self.full_text.split(STOP)[0]
        end
        if !textArr.blank?
          textArr[0..length-1].strip
        else
          ""
        end
      end

      def get_description start_index
        bodyArr = [""]
        if self.full_text.blank?
          ""
        else
          bodyArr = self.full_text.split(STOP)
          (bodyArr.length == 1 ? bodyArr[0][start_index..-1] : (bodyArr[1] || ""))
        end
      end
    end
  end
end
