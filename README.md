# bio-gggenome

[![Build Status](https://secure.travis-ci.org/nakao/bioruby-gggenome.png)](http://travis-ci.org/nakao/bioruby-gggenome)

Ruby client for GGGenome the Ultrafast sequence search, http://gggenome.dbcls.jp/en/

Note: this software is under active development!

## Installation

```sh
    gem install bio-gggenome
```

## Usage

```ruby
    require 'bio-gggenome'
    db = "hg19"
    missmatch = 1
    query = "TTCATTGACAACATT"
    hits = Bio::GGGenome.search(db, missmatch, query)
    
    hits['results'].each do |hit|
      hit['name']     #=> 'chr1'
      hit['position'] #=> 83462476
      hit['strand']   #=> "+"
    end
```

The API doc is online. For more code examples see the test files in
the source tree.
        
## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/nakao/bio-gggenome

The BioRuby community is on IRC server: irc.freenode.org, channel: #bioruby.

## Cite

If you use this software, please cite one of
  
* [BioRuby: bioinformatics software for the Ruby programming language](http://dx.doi.org/10.1093/bioinformatics/btq475)
* [Biogem: an effective tool-based approach for scaling up open source software development in bioinformatics](http://dx.doi.org/10.1093/bioinformatics/bts080)

## Biogems.info

This Biogem is published at [#bio-gggenome](http://biogems.info/index.html)

## Copyright

Copyright (c) 2013 Mitsuteru Nakao. See LICENSE.txt for further details.

