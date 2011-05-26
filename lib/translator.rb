require 'translator/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3

module Translator
  class << self
    attr_accessor :auth_handler, :current_store, :framework_keys
    attr_reader :simple_backend
    attr_writer :layout_name
  end

  @framework_keys = []

  def self.setup_backend(simple_backend)
    @simple_backend = simple_backend

    I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(@current_store), @simple_backend)
  end

  def self.locales
    @simple_backend.available_locales
  end

  def self.keys_for_strings(options = {})
    @simple_backend.available_locales

    flat_translations = {}
    flatten_keys nil, @simple_backend.instance_variable_get("@translations"), flat_translations
    flat_translations = flat_translations.delete_if {|k,v| !v.is_a?(String)}
    keys = (flat_translations.keys + 
            Translator.current_store.keys).map {|k| k.sub(/^\w*\./, '') }.uniq
    if options[:show].to_s == "all"
      keys
    elsif options[:show].to_s == "framework"
      keys.select {|k| @framework_keys.include?(k) }
    else
      keys - @framework_keys
    end
  end

  def self.layout_name
    @layout_name || "translator"
  end

  private

  def self.flatten_keys(current_key, hash, dest_hash)
    hash.each do |key, value|
      full_key = [current_key, key].compact.join('.')
      if value.kind_of?(Hash)
        flatten_keys full_key, value, dest_hash
      else
        dest_hash[full_key] = value
      end
    end
    hash
  end
end

