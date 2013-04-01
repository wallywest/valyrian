module Valyrian
  module Events
    autoload :EventUtils, "valyrian/events/model/event_utils"
    autoload :Default, "valyrian/events/model/default"
    autoload :CompanyEvent, "valyrian/events/model/company"
    autoload :GeoRouteEvent, "valyrian/events/model/georoute"
    autoload :VlabelMapEvent, "valyrian/events/model/vlabelmap"
    autoload :PreRouteEvent, "valyrian/events/model/preroute"
    autoload :PreRouteEditEvent, "valyrian/events/model/preroute_edit"
    autoload :PreRouteConfigEvent, "valyrian/events/model/preroute_config"
    autoload :DliEvent, "valyrian/events/model/dli"
    autoload :FrontEndEvent, "valyrian/events/model/frontend"
    autoload :LocationEvent, "valyrian/events/model/location"
    autoload :PackageEvent, "valyrian/events/model/package"
    autoload :GroupOpEvent, "valyrian/events/model/groupop"
    autoload :IvrEvent, "valyrian/events/model/ivr"
    autoload :AniGroupEvent, "valyrian/events/model/anigroup"
    autoload :StaticEvent, "valyrian/events/model/static"
    autoload :Subevent, "valyrian/events/model/subevent"

    autoload :StatusEvent, "valyrian/events/status/status"

    autoload :ModelMessage, "valyrian/events/model/event_message"
    autoload :StatusMessage, "valyrian/events/status/status_message"
  end
end
