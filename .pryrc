# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  # This introduces the `table` statement
  extend Hirb::Console
end

# What is it?
#   => Helper methods for Apartment::Tenant gem
# How does it work?
#    bin/rails console => auto-loads and asks to switch tenant
#    T.ask             => anytime in console, to switch tenant from a list
#    T.me              => same as Apartment::Tenant.current
#    T.hash            => hash of tenants. Example: { 0 => "public", 1 => "tenant-a" }
#    T.names           => array with all existing tenant names from DB
#    T.exists?(arg)    => returns true/false if `arg` exists as tenant in DB
#    T.switch!(arg)    => same as Apartment::Tenant.switch!
require 'rubygems'

# convenience class
class T
  class << self
    # ['tenant1', 'tenant2', ...]
    def names
      @names ||= Apartment.tenant_names.sort
    end

    # { 0 => 'public', 1 => 'tenant1', ...}
    def hash
      @tenants_hash = {}
      T.names.each_with_index do |tenant, i|
        i += 1
        @tenants_hash.store(i, tenant)
      end
      @hash ||= { 0 => 'public' }.merge(@tenants_hash)
    end

    def switch!(arg)
      Apartment::Tenant.switch!(arg) if T.hash.value?(arg)
    end

    # current tenant
    def me
      Apartment::Tenant.current
    end

    def exists?(arg)
      T.names.include? arg
    end

    # ask to switch the tenant
    def ask
      WelcomeClass.select_tenant
    end
  end
end

# select tenant when entering console
class WelcomeClass
  def self.select_tenant
    puts "Available tenants: #{T.hash}"
    puts ''

    print 'Select tenant: '
    tenant = gets.strip # ask which one?

    unless tenant.empty?
      # by name
      if T.exists?(tenant)
        T.switch!(tenant)

      # by index position
      # string has digit + tenant index present
      elsif tenant[/\d/].present? && T.hash.key?(tenant.to_i)
        T.switch!(T.hash[tenant.to_i])

      # not found = no action
      else
        puts "Tenant not found in list '#{tenant}'"
      end
    end

    # announce current tenant
    puts "You are now in Tenant: '#{T.me}'"
  end
end

# run the code at `bin/rails console`
Pry.config.exec_string = WelcomeClass.select_tenant
