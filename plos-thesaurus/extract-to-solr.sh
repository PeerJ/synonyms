#!/bin/bash
xsltproc extract-to-solr.xslt plos-thesaurus/plosthes.2014-3.extract.xml > synonyms.txt

# Due to highlighting issues with multi-word synonyms 
# (http://www.elasticsearch.org/guide/en/elasticsearch/guide/current/multi-word-synonyms.html)
# We want to use simple contraction to ensure that the RHS has a single term

# Transform to => syntax with last term as preferred
sed 's/\(.*\),\([^,.]*\)$/\1=>\2/g' synonyms.txt > synonyms-contraction.txt

# Synonyms with a single word on both LHS and RHS don't need contraction
grep "^[^, =]*=>[^ ,]*$" synonyms-contraction.txt | sed 's/\(.*\)=>\(.*\)$/\1,\2/g' > synonyms-simple-contraction.txt

# Synonyms with a single word on RHS that have a phrase on LHS
grep "^.*[ ,].*=>[^ ,]*$" synonyms-contraction.txt >> synonyms-simple-contraction.txt

# Take Synonyms with a single word on LHS that have a phrase on RHS and swap LHS with RHS
grep "^[^, =]*=>[^ ]* .*$" synonyms-contraction.txt | sed 's/\(.*\)=>\(.*\)$/\2=>\1/g' >> synonyms-simple-contraction.txt

# Take any 2 word LHS that's mapped to a 2 word RHS and don't contract
# Not entirely sure this will work?
#grep "^[^, =]* [^, =]*=>[^ ]* [^ ]*$" synonyms-contraction.txt >> synonyms-simple-contraction.txt
grep "^[^, =]* [^, =]*=>[^ ]* [^ ]*$" synonyms-contraction.txt | sed 's/\(.*\)=>\(.*\)$/\1,\2/g' >> synonyms-simple-contraction.txt
