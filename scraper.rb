require 'everypolitician'
require 'wikidata/fetcher'

existing = EveryPolitician::Index.new.country("Bangladesh").lower_house.popolo.persons.map(&:wikidata).compact

en = WikiData::Category.new( 'Category:Members of the Jatiya Sangshad', 'en').member_titles |
     WikiData::Category.new( 'Category:Women members of the Jatiyo Sangshad', 'en').member_titles |
     WikiData::Category.new( 'Category:Speakers of the Jatiyo Sangshad', 'en').member_titles
de = WikiData::Category.new( 'Kategorie:Abgeordneter (Bangladesch)', 'de').member_titles
bn = WikiData::Category.new( 'বিষয়শ্রেণী:জাতীয় সংসদ সদস্য', 'bn').member_titles

query = 'SELECT DISTINCT ?item WHERE { ?item p:P39 [ ps:P39/wdt:P279 wd:Q21272758 ] .  }'
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: existing | p39s, names: { en: en, de: de, bn: bn })

