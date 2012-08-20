module Valyrian
class Version
    include Mongoid::Document
    store_in collection: "dev_version"
end
end
