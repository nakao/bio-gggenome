require 'helper'

class TestBioGggenome < Test::Unit::TestCase
  
  def test_new
    assert(Bio::GGGenome.new)
  end
  
  def test_search_result_is_a_hash
    g = Bio::GGGenome.new
    hits = g.search('hg19', '1', 'TTCATTGACAACATT')
    assert_equal(Hash, hits.class)
  end

  def test_search_arguments_3_and_2
    g = Bio::GGGenome.new
    hits = g.search('hg19', '0', 'TTCATTGACAACATT')
    hits1 = g.search('hg19',  'TTCATTGACAACATT')
    assert_equal(hits['summary'][0]['count'],           hits1['summary'][0]['count'])
    assert_equal(hits['summary'][1]['count'],           hits1['summary'][1]['count'])
    assert_equal(hits['summary'][0]['count_is_approx'], hits1['summary'][0]['count_is_approx'])
    assert_equal(hits['summary'][0]['query'],           hits1['summary'][0]['query'])
  end

  def test_class_method_search
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal(Hash, hits.class)
  end
  
  def test_hits_hash_keys
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal(['database', 'error', 'results', 'summary', 'time'].sort, 
                 hits.keys.sort)
  end
  
  def test_hits_database
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal("Human genome, GRCh37/hg19 (Feb, 2009)", hits["database"])
  end
  
  def test_hits_error
    hits = Bio::GGGenome.search('hg19', '1', 'TTCATTGACAACATT')
    assert_equal("none", hits["error"])
  end
  
  def test_hits_summary
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal(Array, hits["summary"].class)
    assert_equal(2, hits["summary"].size)
    assert_equal(['count', 'count_is_approx', 'query'].sort, hits["summary"][0].keys.sort)
    assert_equal(15,                hits["summary"][0]['count'])
    assert_equal(false,             hits["summary"][0]['count_is_approx'])
    assert_equal('TTCATTGACAACATT', hits["summary"][0]['query'])
   end
  
  def test_hits_time
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal(Date.today, Date.parse(hits["time"]))    
  end

  def test_hits_results_size
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal(23, hits["results"].size)    
  end

  def test_hits_results_keys
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal(['name', 'position', 'position_end', 'snippet', 'snippet_pos', 'snippet_end', 'strand'].sort, 
                 hits["results"][0].keys.sort)    
  end
    
  def test_hits_results_0
    hits = Bio::GGGenome.search('hg19', '0', 'TTCATTGACAACATT')
    assert_equal("chr1",   hits["results"][0]['name'])    
    assert_equal(83462476, hits["results"][0]['position'])    
    assert_equal(83462490, hits["results"][0]['position_end'])    
    assert_equal("TTCTCTTCCTCCTCCTCCTCAGCCTCAACATGAAGATGATGAAAATGGAGACCTTCATCGTGATCCACTTCTAATTAATGAATAGTAAGTATATTTTCTCTTCATTGACAACATTTTTCCTCTTACTTTATTGTAAGAATACAATATACGATATATATTGCCATGCAAAATATGTGTTAATTGACTATATTATATTATTGATAGGACTTCTTGAG",
                           hits["results"][0]['snippet'])    
    assert_equal(83462376, hits["results"][0]['snippet_pos'])    
    assert_equal(83462590, hits["results"][0]['snippet_end'])    
    assert_equal("+",      hits["results"][0]['strand'])    
  end

end
