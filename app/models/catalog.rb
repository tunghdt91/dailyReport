class Catalog < ActiveRecord::Base
  attr_accessible :name, :detail

  validates :name, presence: true

  def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << name
    all.each do |catalog|
      csv << catalog.attributes.values_at(name)
    end
  end
end
end