synonyms
=======

PeerJ Elasticsearch/Solr Synonyms

PLOS Synonyms
* URL: https://github.com/PLOS/plos-thesaurus
* License: CC-BY 2.5

MeSH 
* URL: http://www.nlm.nih.gov/mesh/termscon.html
* License: U.S. National Library of Medicine must be identified as the creator, maintainer, and provider of the data;

Current PeerJ Usage:
* Synonyms:
  * Run: https://github.com/PeerJ/synonym/blob/master/plos-thesaurus/extract-to-solr.sh
  * Concat with: https://github.com/PeerJ/synonym/blob/master/peerj/synonyms.txt
  * Deploy to ES servers & re-index

* MeSH Data:
  * NOTE: current process assumes that ` is not present in the dataset exported.  Should be checked prior to running or alternatively, look at the php script
  * Run: https://github.com/PeerJ/synonym/blob/master/mesh/desc-to-db.sh
  * Import sql file into db (If updating, will need to remove old data)
  * Reindex es mesh index  
