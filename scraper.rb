require 'everypolitician'
require 'wikidata/fetcher'

existing = EveryPolitician::Index.new.country("Bangladesh").lower_house.popolo.persons.map(&:wikidata).compact

en = WikiData::Category.new( 'Category:9th Jatiya Sangsad members', 'en').wikidata_ids |
     WikiData::Category.new( 'Category:10th Jatiya Sangsad members', 'en').wikidata_ids

bn_9 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://bn.wikipedia.org/wiki/%E0%A6%A8%E0%A6%AC%E0%A6%AE_%E0%A6%9C%E0%A6%BE%E0%A6%A4%E0%A7%80%E0%A6%AF%E0%A6%BC_%E0%A6%B8%E0%A6%82%E0%A6%B8%E0%A6%A6_%E0%A6%B8%E0%A6%A6%E0%A6%B8%E0%A7%8D%E0%A6%AF%E0%A6%A6%E0%A7%87%E0%A6%B0_%E0%A6%A4%E0%A6%BE%E0%A6%B2%E0%A6%BF%E0%A6%95%E0%A6%BE',
  xpath: '//table[.//th[contains(.,"নির্বাচনী এলাকা")]]//tr[td]//td[2]//a[not(@class="new")]/@title',
  as_ids: true,
).compact

# TODO unspan the table first
bn_10 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://bn.wikipedia.org/wiki/%E0%A6%A6%E0%A6%B6%E0%A6%AE_%E0%A6%9C%E0%A6%BE%E0%A6%A4%E0%A7%80%E0%A6%AF%E0%A6%BC_%E0%A6%B8%E0%A6%82%E0%A6%B8%E0%A6%A6_%E0%A6%B8%E0%A6%A6%E0%A6%B8%E0%A7%8D%E0%A6%AF%E0%A6%A6%E0%A7%87%E0%A6%B0_%E0%A6%A4%E0%A6%BE%E0%A6%B2%E0%A6%BF%E0%A6%95%E0%A6%BE',
  xpath: '//table[.//th[contains(.,"নাম")]]//tr[td]//td[2]//a[not(@class="new")]/@title',
  as_ids: true,
).compact

query = 'SELECT DISTINCT ?item WHERE { ?item p:P39 [ ps:P39/wdt:P279 wd:Q13058882 ] }'
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: existing | p39s | en | bn_9 | bn_10)
