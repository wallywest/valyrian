class Alpha
  include Mongoid::Document
  store_in collection: "alpha"

  scope :packages, ->{where(controller: "packages")}
  #scope :activations, where(action: "activate")
  #scope :no_activations, excludes(action: "activate")
  #scope :vlabels, where(controller: "backend_numbers")
  #scope :frontend, where(controller: "/frontend/")
  #scope :session, where(controller: "Session").limit(1)
  #scope :cache_refresh, where(controller: "cache_refresh").limit(1)
  scope :anis, ->{where(controller: "ani_groups")}
  #scope :company, where(controller: /company/i)
  #scope :dli, where(controller: /dlis/i)
  #scope :frontend, where(controller: /frontend/i)
  #scope :groupop, where(controller: /^groups$/i)
  #scope :georoute, where(controller: /geo_route_groups/i)
  #scope :preroute, where(controller: /preroute.*$/i)
  #scope :ivrs, where(controller: /ivr/i)


  def master_event(type)
    self.events.select{|s| s["type"] == type}.first
  end
  def activation_events(type)
    self.events.select{|s| s["type"] == type}
  end

  def self.package_children
  end

end
