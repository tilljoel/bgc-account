# encoding: utf-8

module BGC
  module Account
    module Validations

      def self.included(klass)
        klass.class_eval do
          include ActiveModel::Validations
          validate :check_errors
        end
      end

      def check_errors
        check_checksum
      end

      def check_checksum
        errors.add(:account, 'invalid checksum') unless valid_checksum?
      end

    end
  end
end
