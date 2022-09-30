# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_name = "@#{name}".to_sym
      history_var_name = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(history_var_name) || [] }
      define_method("#{name}=") do |value|
        instance_variable_set(history_var_name, public_send("#{name}_history") << value)
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(**kwargs)
    kwargs.each_key do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        raise "Wrong class: #{value.class}" unless kwargs[name].to_s == value.class.to_s

        instance_variable_set(var_name, value)
      end
    end
  end
end
