require 'json'

module BRPopulate
  def self.states
    ActiveSupport::JSON.decode(Rails.root.join("db", "states.json"))
  end

  def self.capital?(city, state)
    city["name"] == state["capital"]
  end

  def self.populate
    states.each do |state|
      state_obj = State.create(acronym: state["acronym"], name: state["name"])

      state["cities"].each do |city|
        City.create(name: city, state: state_obj, capital: capital?(city, state))
      end
    end
  end
end

BRPopulate.populate