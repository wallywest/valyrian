module Valyrian
class Event
    include Mongoid::Document
    store_in collection: "dev_archive"
end
end
