Feature: Lodging Emissions Calculations
  The lodging model should generate correct emission calculations

  Background:
    Given a Lodging

  Scenario: Calculations starting from nothing
    Given a lodging has nothing
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "28.50"

  Scenario Outline: Calculations starting from date
    Given it has "date" of "<date>"
    And it has "timeframe" of "<timeframe>"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "<carbon>"
    Examples:
      | date       | timeframe             | carbon |
      | 2011-01-15 | 2011-01-01/2012-01-01 |  28.50 |
      | 2012-01-15 | 2011-01-01/2012-01-01 |   0.0  |

  Scenario: Calculations starting from rooms and duration
    Given it has "rooms" of "2"
    And it has "duration" of "172800"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "113.98"

  Scenario Outline: Calculations from fuzzy inference based on country degree days
    Given it has "rooms" of "2"
    And it has "duration" of "172800"
    And it has "country.iso_3166_code" of "<country>"
    And it has "state.postal_abbreviation" of "<state>"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "<carbon>"
    Examples:
      | country | state | carbon |
      | VI      |       | 113.98 |
      | GB      |       |  91.94 |
      | US      |       |  78.18 |
      |         | CA    |  78.18 |

  Scenario Outline: Calculations from fuzzy inference
    Given it has "rooms" of "2"
    And it has "duration" of "172800"
    And it has "property.northstar_id" of "<id>"
    And it has "zip_code.name" of "<zip>"
    And it has "city" of "<city>"
    And it has "state.postal_abbreviation" of "<state>"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "<carbon>"
    Examples:
      | id | zip   | city          | state | carbon | notes |
      | 1  | 94122 |               |       |  21.00 | dd from climate divizion; fuzzy from property attributes |
      | 1  |       | San Francisco | CA    |  41.93 | dd from country; fuzzy from property attributes |
      | 2  | 94133 |               |       |  57.48 | dd from country; fuzzy from property attributes |
      | 2  |       | San Francisco | CA    |  57.48 | dd from country; fuzzy from property attributes |
      | 3  | 94014 |               |       |  58.59 | dd from country; fuzzy from property attributes |
      | 3  |       | San Francisco | CA    |  58.59 | dd from country; no find hotel |
