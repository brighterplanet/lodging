module BrighterPlanet
  module Lodging
    module Relationships
      def self.included(target)
        target.belongs_to :zip_code,      :foreign_key => 'zip_code_name'
        target.belongs_to :state,         :foreign_key => 'state_postal_abbreviation'
        target.belongs_to :country,       :foreign_key => 'country_iso_3166_code'
        target.belongs_to :property,      :foreign_key => 'property_northstar_id', :class_name => 'LodgingProperty'
      end
    end
  end
end
