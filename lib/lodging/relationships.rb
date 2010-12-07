module BrighterPlanet
  module Lodging
    module Relationships
      def self.included(target)
        target.belongs_to :lodging_class, :foreign_key => 'lodging_class_name'
        target.belongs_to :zip_code,      :foreign_key => 'zip_code_name'
        target.belongs_to :state,         :foreign_key => 'state_postal_abbreviation'
      end
    end
  end
end
