require 'rubygems'
require 'json'
require 'uri'
require 'bio'

module Bio
  
  # Bio::GGGenome
  #
  # gggenome = Bio::GGGenome.new
  # hits = gggenome.search("hg19", 1, "TTCATTGACAACATT")
  # hits = gggenome.search("hg19", "TTCATTGACAACATT")
  # hits = gggenome.search("TTCATTGACAACATT")
  #
  # hits = Bio::GGGenome.search("hg19", "TTCATTGACAACATT")
  #
  class GGGenome
    BASE_URL = "http://gggenome.dbcls.jp"    

    def self.search(*args)
      new.search(args)
    end
        
    def initialize(uri = BASE_URL)
      uri = URI.parse(uri) unless uri.kind_of?(URI)
      @pathbase = uri.path
      @pathbase = '/' + @pathbase unless /\A\// =~ @pathbase
      @pathbase = @pathbase + '/' unless /\/\z/ =~ @pathbase
      @http = Bio::Command.new_http(uri.host, uri.port)
      @header = {
        'User-Agent' => "BioRuby/#{Bio::BIORUBY_VERSION_ID}"
      }
    end
    
    # Search, returns a result hash.
    # Bio::GGGenome#search("hg19", 1, "TTCATTGACAACATT")
    # Bio::GGGenome#search("hg19", "TTCATTGACAACATT")
    # Bio::GGGenome#search(1, "TTCATTGACAACATT")
    # Bio::GGGenome#search("TTCATTGACAACATT")
    # Bio::GGGenome#search("http://gggenome.dbcls.jp/hg19/TTCATTGACAACATTGCGT.json")
    def search(*args)
      db        = nil
      missmatch = nil
      
      if args[0] =~ /^http/
        args[0].sub!(BASE_URL, '')
        args[0].sub!(/^\//,'')
        args[0].sub!(".json", '')
        args = args[0].split("/")        
      end
      
      case args.size
      when 1
        seq = args.shift
      when 2
        if args[0].to_s.strip =~ /^[0-9]+$/
          missmatch,seq = args
        else
          db,seq = args
        end  
      when 3
        db,missmatch,seq = args
      else
        raise ArgumentError
      end     
      query = ['', db, missmatch, seq].compact.join("/")
      path =  query + ".json"
      begin
        response = @http.get(path, @header)
      rescue
      end

      case response.code
      when "200"
        JSON.parse(response.body)
      when "302"
        location = response.header['Location']
        search(location)
      else
        nil
      end
    end
  end
  
end
