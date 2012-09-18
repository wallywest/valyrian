module Valyrian::Service::Discovery

  VLABEL_ASSOC = ['survey_group_id','preroute_group_id','geo_route_group_id']

  def wtf
    puts "wtf"
  end

  def vlabel_change_event
    @changed.each do |key,value|
      if VLABEL_ASSOC.include?(key)
        message_for_assoc(key,value)
      else
        unless geo_route_change(value)
          changed << {key => value}
        end
      end
    end
  end

  def message_for_assoc(key,value)
    type = key.split("_id").first
    if value_disabled?(value)
      message = "#{type.classify} option is removed"
    else
      return if @assoc.nil?
      message = "#{type.classify} #{@assoc[type]} was added"
    end
    add_sub_event(message)
  end

  def geo_route_change(value)
    value.select{|x| x =~ /GEO_ROUTE_SUB0/}.size > 0
  end

  def value_disabled?(value)
    value[1].nil? || value[1] == 0
  end

end
