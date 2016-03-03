require "breakable/version"

module Breakable
  class ActiveRecord::Base
    def self.is_breakable body=nil
      include Synonymable
      if body
        # TODO add method
      end
    end
  end
  module Breakable
    extend ActiveSupport::Concern

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
          textArr = self.full_text.split(self.stop)[0]
        end
        if !textArr.blank?
          textArr[0..length].strip
        else
          ""
        end
      end

      def get_description start_index
        bodyArr = [""]
        if self.full_text.blank?
          ""
        else
          bodyArr = self.full_text.split(self.stop)
          (bodyArr.length == 1 ? bodyArr[0][start_index..-1] : (bodyArr[1] || ""))
        end
      end

      def stop
        %Q(<!--break-->)
      end
    end
  end
end
