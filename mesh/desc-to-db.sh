#!/bin/bash
xsltproc desc-to-db.xslt downloads/desc2015.xml > mesh.sql
sed -i "s/'/\\\'/g" mesh.sql
sed -i "s/\`/\'/g" mesh.sql
