require 'everypolitician'
require 'wikidata/fetcher'

existing = EveryPolitician::Index.new.country("Bangladesh").lower_house.popolo.persons.map(&:wikidata).compact

en = WikiData::Category.new( 'Category:9th Jatiya Sangsad members', 'en').wikidata_ids |
     WikiData::Category.new( 'Category:10th Jatiya Sangsad members', 'en').wikidata_ids
bn = WikiData::Category.new( 'বিষয়শ্রেণী:জাতীয় সংসদ সদস্য', 'bn').wikidata_ids

query = 'SELECT DISTINCT ?item WHERE { ?item p:P39 [ ps:P39/wdt:P279 wd:Q13058882 ] }'
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: existing | p39s | en | bn)
