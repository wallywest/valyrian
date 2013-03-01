module Valyrian
  module EventUtils

    def rules
      #yaml file of definitions for identifiers
      Valyrian.rules
    end

    def add_sub_event(message)
      unless @message.sub_events.include?(message)
        if message.class == Array
          message.flatten.each {|x| @message.sub_events << x}
        else
          @message.sub_events << message
        end
      end
    end

    def object_ident
      if has_const?("IDENTITY_RULE")
        rules[self.class.const_get("IDENTITY_RULE")]
      else
        rules[@controller] ||= {}
      end
    end

    def object_name
      object_ident["model"] ||= @controller.classify
    end

    def attributes
      #returns attribute associated with identity
      object_ident["object"] ||= []
    end

    def add_meta(h)
      @message.meta = h
    end

    def add_change_message(changed)
      @message.changed << changed
    end

    def set_identity(ident)
      @identity = ident
      @message.identity = ident
    end

    def missing_identity?
      @identity.nil?
    end

    def set_template(template)
      @message.template = template
    end

    def has_const?(const)
      self.class.const_defined?(const)
    end

    def find_from_object(object,type)
      attributes.each do |attr|
        return object[attr] if type == object_name
      end
      nil
    end

    def assoc_field_for(model)
      rules[model]["object"].first
    end

    def find_from_assoc(assoc)
      return nil unless has_const?("ASSOC")
      return nil if @assoc.nil?
      model = self.class.const_get("ASSOC")
      value = assoc[model]
      if value.kind_of?(Hash)
        value = value[assoc_field_for(model.pluralize)]
      end
      value
    end

    def main_type
      if has_const?("MAIN")
        self.class.const_get("MAIN")
      else
        object_name
        #@controller.classify
      end
    end

    def has_main_type_changed?(changed)
      return false if changed.nil?
      return false if has_changed_subevent?
      return false if !main_type.include?(@type)
      true
    end

    def matchingRule?
      @match = false
      if has_const?("RULES")
        rule_definitions.each do |rule|
          @match = rule[:criteria].call(self)
        end
      end
      @match
    end

    def has_subevents?
      has_const?("SUBEVENTS")
    end

    def has_changed_subevent?
      return true if has_subevents? && !definitions.select {|x| x[:type] == :changed}.empty?
      false
    end

    def definitions
      self.class.const_get("SUBEVENTS")
    end

    def rule_definitions
      self.class.const_get("RULES")
    end

        
    def value_disabled?(value)
      value.nil? || value == 0
    end   

    def diff_message(type,field,old,new)
      return if old == new
      if value_disabled?(old)
        m = "#{type} #{new[field]} is enabled"
      elsif value_disabled?(new)
        m = "#{type} #{old[field]} is disabled"
      else
        m = "#{type} #{old[field]} is changed to #{new[field]}"
      end
    end

    def diff_message_id(type,value,old,new)
      if value_disabled?(old)
        m = "#{type} #{value} is enabled"
      elsif value_disabled?(new)
        m = "#{type} is disabled"
      else
      end
    end

  end
end
