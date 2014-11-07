<?php

// open the MeSH descriptor XML
$reader = new XMLReader;
$reader->open('desc2015.xml');

// open the output CSV and write the header row
$output = fopen('mesh.csv', 'w');
fputcsv($output, array('descriptor', 'term'));

$i = 0;

while ($reader->read()) {
  if ($reader->nodeType == XMLREADER::ELEMENT && $reader->localName == 'DescriptorRecord') {
    $dom = new DOMDocument;
    $xpath = new DOMXPath($dom);

    $record = $dom->importNode($reader->expand(), true);
    $description = $xpath->evaluate('string(DescriptorName/String)', $record);
    $nodes = $xpath->query('ConceptList/Concept/TermList/Term/String', $record);

    foreach ($nodes as $node) {
      $term = $node->textContent;

      if ($term !== $description) {
        fputcsv($output, array($description, $term));
        fputcsv($output, array($term, $description));
      }
    }

    if (++$i % 1000 === 0) {
      print "Parsed $i items\n";
    }
  }
}

print "Parsed $i items\n";