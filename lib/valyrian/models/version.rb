module Valyrian
class Version
    include Mongoid::Document
    store_in collection: "dev_versions"

    scope :find_version, ->(oid){ where("v.oid" => Moped::BSON::ObjectId(oid)) }

    def self.version_pairs(oid)
       o = self.find_version(oid).first
       versions = o.v
       last_version = o.l.to_s
       i = versions.index{|x| x["oid"].to_s == oid}
       if last_version == oid
         return convert_version_pairs(versions[i])
       else
         return convert_version_pairs(versions[i..i+1])
       end
    end

    def self.convert_version_pairs(v)
      if v.kind_of?(Hash)
         [Marshal.load(v["p"].to_s)]
      else
        v.map do |x|
          Marshal.load(x["p"].to_s)
        end
      end
    end

end
end
