module Valyrian
  module Utils

    def logger
      Valyrian.logger
    end

    def rules
      #yaml file of definitions for identifiers
      Valyrian.rules
    end

    def add_sub_event(message)
      unless @message.sub_events.include?(message)
        @message.sub_events << message
      end
    end

    def object_ident
      rules[@controller] ||= {}
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
      @identifier = ident
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

    def has_main_type_changed?(changed)
      return false if changed.nil?
      return false if has_const?("SUBEVENTS")
      true
    end

  end
end
