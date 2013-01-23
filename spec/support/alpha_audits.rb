class Alpha
  include Mongoid::Document
  store_in collection: "alpha"

  scope :packages, where(controller: "packages")
  scope :activations, where(action: "activate")
  scope :no_activations, excludes(action: "activate")
  scope :vlabels, where(controller: "backend_numbers")
  scope :frontend, where(controller: "/frontend/")

  def master_event(type)
    self.events.select{|s| s["type"] == type}.first
  end
  def activation_events(type)
    self.events.select{|s| s["type"] == type}
  end

end
