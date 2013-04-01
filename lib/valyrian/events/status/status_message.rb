module Virtus
  class Coercion
    class String < Virtus::Coercion::Object
      def self.past_tense(value)
        Verbs::Conjugator.conjugate value.to_sym, :tense => :past, :aspect => :perfective
      end
    end
  end
end

class PastTense < Virtus::Attribute::Object
  primitive String
  coercion_method :past_tense
end

module Valyrian::Events
  class StatusMessage
    include Virtus
    
    attribute :template, String
    attribute :type, String
    attribute :action, PastTense
  end
end
