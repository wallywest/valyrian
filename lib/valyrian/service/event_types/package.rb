module Valyrian::Service
class PackageEvent < Valyrian::Service::Default
  attr_reader :message

  TEMPLATE = 'package'

  def initialize(controller,events,action,assoc)
    @events = events
    @controller = controller
    @action = action

    @category = assoc.delete("category")
    @default = assoc.delete("group_default")
    @group = assoc.delete("display_name")
    @name = assoc.delete("name")

    @assoc = assoc.merge!({"group" => @group})
    #set_category

    @message = {"template" => template, "identity" => @name, "meta" => @assoc}

    logger.info("Message: #{@message}\n Type: #{self.class}")
  end


  private

  def template
    TEMPLATE
  end

  #def set_category
    #if @default == 1
      #cat = 'default' 
    #else
      #if @category == 'f'
        #cat = 'many_to_one'
      #else
        #cat = 'one_to_one'
      #end
    #end
    #@assoc.merge!({"category" => cat.titleize})
  #end

end
end
