# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10 
    }

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}' 
    #}

    #config for xmlitem webservice JSP 05/16/2012
    config.xmlitem_url = 'http://libexp.uits.iu.edu/xmlitem2.cgi?key='

    # solr field configuration for search results/index views
    config.index.show_link = 'title'
    config.index.record_display_type = 'volume'

    # solr field configuration for document/show views
    config.show.html_title = 'title'
    config.show.heading = 'title'
    config.show.display_type = 'volume'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar
    config.add_facet_field 'volume', :label => 'Volume/APUG', :limit => 10, :sort => 'index' 
    config.add_facet_field 'names_facet', :label => 'Name', :limit => 10 
    config.add_facet_field 'occupations_facet', :label => 'Occupation', :limit => 10 
    config.add_facet_field 'places_facet', :label => 'Place', :limit => 10 
    config.add_facet_field 'year_sort', :label => 'Year', :range => true
    config.add_facet_field 'text_type', :label => 'Text Type', :limit => 10 
    config.add_facet_field 'subject', :label => 'Subject', :limit => 20 



    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'title', :label => 'Title:' 
    config.add_index_field 'volume', :label => 'Volume/APUG:' 
    config.add_index_field 'language', :label => 'Languag(e):' 
    config.add_index_field 'subject', :label => 'Subject(s):'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'title', :label => 'Title:' 
    config.add_show_field 'volume', :label => 'Volume/APUG:'
    config.add_show_field 'sender', :label => 'Sender:' 
    config.add_show_field 'sender_occ', :label => 'Occupation of Sender:' 
    config.add_show_field 'recipient', :label => 'Recipient:' 
    config.add_show_field 'recipient_occ', :label => 'Occupation of Recipient:' 
    config.add_show_field 'author', :label => 'Author:' 
    config.add_show_field 'author_occ', :label => 'Occupation of Author:' 
    config.add_show_field 'text_type', :label => 'Text Type:' 
    config.add_show_field 'language', :label => 'Language:'
    config.add_show_field 'annotator', :label => 'Annotator:' 
    config.add_show_field 'annotator_occ', :label => 'Occupation of Annotator:' 
    config.add_show_field 'author_of_cited_book', :label => 'Author of Cited Book:' 
    config.add_show_field 'author_of_cited_book_occ', :label => 'Occupation of Author of Cited Book:' 
    config.add_show_field 'author_of_postscript_book', :label => 'Author of Postscript:' 
    config.add_show_field 'author_of_postscript_occ', :label => 'Occupation of Author of Postscript:' 
    config.add_show_field 'copyist', :label => 'Copyist:' 
    config.add_show_field 'copyist_occ', :label => 'Occupation of Copyist:' 
    config.add_show_field 'ex_libris', :label => 'Ex Libris:' 
    config.add_show_field 'ex_libris_occ', :label => 'Occupation of Ex Libris:' 
    config.add_show_field 'presumed_author', :label => 'Presumed Author:' 
    config.add_show_field 'presumed_author_occ', :label => 'Occupation of Presumed Author:' 
    config.add_show_field 'presumed_sender', :label => 'Presumed Sender:' 
    config.add_show_field 'presumed_sender_occ', :label => 'Occupation of Presumed Sender:' 
    config.add_show_field 'quoted_name', :label => 'Quoted Name:' 
    config.add_show_field 'quoted_name_occ', :label => 'Occupation of Quoted Name:' 
    config.add_show_field 'related_name', :label => 'Related Name:' 
    config.add_show_field 'related_name_occ', :label => 'Occupation of Related Name:' 
    config.add_show_field 'signatory', :label => 'Signatory:' 
    config.add_show_field 'signatory_occ', :label => 'Occupation of Signatory:' 
    config.add_show_field 'translator', :label => 'Translator:' 
    config.add_show_field 'translator_occ', :label => 'Occupation of Translator:' 
	config.add_show_field 'old_style_letter_date', :label => 'Date of Old Style Letter:' 
    config.add_show_field 'old_style_letter_place', :label => 'Place of Old Style Letter:' 
    config.add_show_field 'acomp_date', :label => 'Date of Accompanying Text:' 
    config.add_show_field 'acomp_place', :label => 'Place of Accompanying Text:'
    config.add_show_field 'composition_date', :label => 'Date of Composition:' 
    config.add_show_field 'composition_place', :label => 'Place of Composition:' 
    config.add_show_field 'copy_date', :label => 'Date of Copy:' 
    config.add_show_field 'copy_place', :label => 'Place of Copy:' 
    config.add_show_field 'new_document_date', :label => 'Date of New Document:' 
    config.add_show_field 'new_document_place', :label => 'Place of New Document:' 
    config.add_show_field 'letter_date', :label => 'Date of Letter:' 
    config.add_show_field 'letter_place', :label => 'Place of Letter:' 
    config.add_show_field 'new_style_letter_date', :label => 'Date of New Style Letter:' 
    config.add_show_field 'new_style_letter_place', :label => 'Place of New Style Letter:' 
    config.add_show_field 'letter_ab_date', :label => 'Date of Letter (ab inc.):' 
    config.add_show_field 'letter_ab_place', :label => 'Place of Letter (ab inc.):' 
    config.add_show_field 'letter_referred_to_date', :label => 'Date of Letter Referred To:' 
    config.add_show_field 'letter_referred_to_place', :label => 'Place of Letter Referred To:' 
    config.add_show_field 'manuscript_referred_to_date', :label => 'Date of Manuscript Referred To:' 
    config.add_show_field 'manuscript_referred_to_place', :label => 'Place of Manuscript Referred To:' 
    config.add_show_field 'manuscript_date', :label => 'Date of Manuscript:' 
    config.add_show_field 'manuscript_place', :label => 'Place of Manuscript:' 
    config.add_show_field 'observation_date', :label => 'Date of Observation:' 
    config.add_show_field 'observation_place', :label => 'Place of Observation:' 
    config.add_show_field 'original_sent_date', :label => 'Date of Original Sent:' 
    config.add_show_field 'original_sent_place', :label => 'Place of Original Sent:' 
    config.add_show_field 'proclamation_date', :label => 'Date of Proclamation:' 
    config.add_show_field 'proclamation_place', :label => 'Place of Proclamation:' 
    config.add_show_field 'publication_date', :label => 'Date of Publication:' 
    config.add_show_field 'publication_place', :label => 'Place of Publication:' 
    config.add_show_field 'quoted_date', :label => 'Date Quoted:' 
    config.add_show_field 'quoted_place', :label => 'Place Quoted:' 
    config.add_show_field 'url1', :label => 'Image 1:', :helper_method => :render_external_link
    config.add_show_field 'url2', :label => 'Image 2:', :helper_method => :render_external_link
    config.add_show_field 'url3', :label => 'Image 3:', :helper_method => :render_external_link
    config.add_show_field 'url4', :label => 'Image 4:', :helper_method => :render_external_link
    config.add_show_field 'url5', :label => 'Image 5:', :helper_method => :render_external_link
    config.add_show_field 'url6', :label => 'Image 6:', :helper_method => :render_external_link
    config.add_show_field 'url7', :label => 'Image 7:', :helper_method => :render_external_link
    config.add_show_field 'url8', :label => 'Image 8:', :helper_method => :render_external_link
    config.add_show_field 'url9', :label => 'Image 9:', :helper_method => :render_external_link
    config.add_show_field 'url10', :label => 'Image 10:', :helper_method => :render_external_link
    config.add_show_field 'url11', :label => 'Image 11:', :helper_method => :render_external_link
    config.add_show_field 'url12', :label => 'Image 12:', :helper_method => :render_external_link
    config.add_show_field 'url13', :label => 'Image 13:', :helper_method => :render_external_link
    config.add_show_field 'url14', :label => 'Image 14:', :helper_method => :render_external_link
    config.add_show_field 'url15', :label => 'Image 15:', :helper_method => :render_external_link
    config.add_show_field 'url16', :label => 'Image 16:', :helper_method => :render_external_link
    config.add_show_field 'url17', :label => 'Image 17:', :helper_method => :render_external_link
    config.add_show_field 'url18', :label => 'Image 18:', :helper_method => :render_external_link
    config.add_show_field 'url19', :label => 'Image 19:', :helper_method => :render_external_link
    config.add_show_field 'url20', :label => 'Image 20:', :helper_method => :render_external_link
    config.add_show_field 'url21', :label => 'Image 21:', :helper_method => :render_external_link
    config.add_show_field 'url22', :label => 'Image 22:', :helper_method => :render_external_link
    config.add_show_field 'url23', :label => 'Image 23:', :helper_method => :render_external_link
    config.add_show_field 'url24', :label => 'Image 24:', :helper_method => :render_external_link
    config.add_show_field 'url25', :label => 'Image 25:', :helper_method => :render_external_link
    config.add_show_field 'url26', :label => 'Image 26:', :helper_method => :render_external_link
    config.add_show_field 'url27', :label => 'Image 27:', :helper_method => :render_external_link
    config.add_show_field 'url28', :label => 'Image 28:', :helper_method => :render_external_link
    config.add_show_field 'url29', :label => 'Image 29:', :helper_method => :render_external_link
    config.add_show_field 'url30', :label => 'Image 30:', :helper_method => :render_external_link
    config.add_show_field 'url31', :label => 'Image 31:', :helper_method => :render_external_link
    config.add_show_field 'url32', :label => 'Image 32:', :helper_method => :render_external_link
    config.add_show_field 'url33', :label => 'Image 33:', :helper_method => :render_external_link
    config.add_show_field 'url34', :label => 'Image 34:', :helper_method => :render_external_link
    config.add_show_field 'url35', :label => 'Image 35:', :helper_method => :render_external_link
    config.add_show_field 'url36', :label => 'Image 36:', :helper_method => :render_external_link
    config.add_show_field 'url37', :label => 'Image 37:', :helper_method => :render_external_link
    config.add_show_field 'url38', :label => 'Image 38:', :helper_method => :render_external_link
    config.add_show_field 'url39', :label => 'Image 39:', :helper_method => :render_external_link
    config.add_show_field 'url40', :label => 'Image 40:', :helper_method => :render_external_link
    config.add_show_field 'url41', :label => 'Image 41:', :helper_method => :render_external_link
    config.add_show_field 'url42', :label => 'Image 42:', :helper_method => :render_external_link
    config.add_show_field 'url43', :label => 'Image 43:', :helper_method => :render_external_link
    config.add_show_field 'url44', :label => 'Image 44:', :helper_method => :render_external_link
    config.add_show_field 'url45', :label => 'Image 45:', :helper_method => :render_external_link
    config.add_show_field 'url46', :label => 'Image 46:', :helper_method => :render_external_link
    config.add_show_field 'url47', :label => 'Image 47:', :helper_method => :render_external_link
    config.add_show_field 'url48', :label => 'Image 48:', :helper_method => :render_external_link
    config.add_show_field 'url49', :label => 'Image 49:', :helper_method => :render_external_link
    config.add_show_field 'url50', :label => 'Image 50:', :helper_method => :render_external_link
    config.add_show_field 'url51', :label => 'Image 51:', :helper_method => :render_external_link
    config.add_show_field 'url52', :label => 'Image 52:', :helper_method => :render_external_link
    config.add_show_field 'url53', :label => 'Image 53:', :helper_method => :render_external_link
    config.add_show_field 'url54', :label => 'Image 54:', :helper_method => :render_external_link
    config.add_show_field 'url55', :label => 'Image 55:', :helper_method => :render_external_link
    config.add_show_field 'url56', :label => 'Image 56:', :helper_method => :render_external_link
    config.add_show_field 'url57', :label => 'Image 57:', :helper_method => :render_external_link
    config.add_show_field 'url58', :label => 'Image 58:', :helper_method => :render_external_link
    config.add_show_field 'url59', :label => 'Image 59:', :helper_method => :render_external_link
    config.add_show_field 'url60', :label => 'Image 60:', :helper_method => :render_external_link
    config.add_show_field 'url61', :label => 'Image 61:', :helper_method => :render_external_link
    config.add_show_field 'url62', :label => 'Image 62:', :helper_method => :render_external_link
    config.add_show_field 'url63', :label => 'Image 63:', :helper_method => :render_external_link
    config.add_show_field 'url64', :label => 'Image 64:', :helper_method => :render_external_link
    config.add_show_field 'url65', :label => 'Image 65:', :helper_method => :render_external_link
    config.add_show_field 'url66', :label => 'Image 66:', :helper_method => :render_external_link
    config.add_show_field 'url67', :label => 'Image 67:', :helper_method => :render_external_link
    config.add_show_field 'url68', :label => 'Image 68:', :helper_method => :render_external_link
    config.add_show_field 'url69', :label => 'Image 69:', :helper_method => :render_external_link
    config.add_show_field 'url70', :label => 'Image 70:', :helper_method => :render_external_link
    config.add_show_field 'url71', :label => 'Image 71:', :helper_method => :render_external_link
    config.add_show_field 'url72', :label => 'Image 72:', :helper_method => :render_external_link
    config.add_show_field 'url73', :label => 'Image 73:', :helper_method => :render_external_link
    config.add_show_field 'url74', :label => 'Image 74:', :helper_method => :render_external_link
    config.add_show_field 'url75', :label => 'Image 75:', :helper_method => :render_external_link
    config.add_show_field 'url76', :label => 'Image 76:', :helper_method => :render_external_link
    config.add_show_field 'url77', :label => 'Image 77:', :helper_method => :render_external_link
    config.add_show_field 'url78', :label => 'Image 78:', :helper_method => :render_external_link
    config.add_show_field 'url79', :label => 'Image 79:', :helper_method => :render_external_link
    config.add_show_field 'url80', :label => 'Image 80:', :helper_method => :render_external_link
    config.add_show_field 'url81', :label => 'Image 81:', :helper_method => :render_external_link
    config.add_show_field 'url82', :label => 'Image 82:', :helper_method => :render_external_link
    config.add_show_field 'url83', :label => 'Image 83:', :helper_method => :render_external_link
    config.add_show_field 'url84', :label => 'Image 84:', :helper_method => :render_external_link
    config.add_show_field 'url85', :label => 'Image 85:', :helper_method => :render_external_link
    config.add_show_field 'url86', :label => 'Image 86:', :helper_method => :render_external_link
    config.add_show_field 'url87', :label => 'Image 87:', :helper_method => :render_external_link
    config.add_show_field 'url88', :label => 'Image 88:', :helper_method => :render_external_link
    config.add_show_field 'url89', :label => 'Image 89:', :helper_method => :render_external_link
    config.add_show_field 'url90', :label => 'Image 90:', :helper_method => :render_external_link
    config.add_show_field 'url91', :label => 'Image 91:', :helper_method => :render_external_link
    config.add_show_field 'url92', :label => 'Image 92:', :helper_method => :render_external_link
    config.add_show_field 'url93', :label => 'Image 93:', :helper_method => :render_external_link
    config.add_show_field 'url94', :label => 'Image 94:', :helper_method => :render_external_link
    config.add_show_field 'url95', :label => 'Image 95:', :helper_method => :render_external_link
    config.add_show_field 'url96', :label => 'Image 96:', :helper_method => :render_external_link
    config.add_show_field 'url97', :label => 'Image 97:', :helper_method => :render_external_link
    config.add_show_field 'url98', :label => 'Image 98:', :helper_method => :render_external_link
    config.add_show_field 'url99', :label => 'Image 99:', :helper_method => :render_external_link
    config.add_show_field 'url100', :label => 'Image 100:', :helper_method => :render_external_link
    config.add_show_field 'url101', :label => 'Image 101:', :helper_method => :render_external_link
    config.add_show_field 'url102', :label => 'Image 102:', :helper_method => :render_external_link
    config.add_show_field 'url103', :label => 'Image 103:', :helper_method => :render_external_link
    config.add_show_field 'url104', :label => 'Image 104:', :helper_method => :render_external_link
    config.add_show_field 'url105', :label => 'Image 105:', :helper_method => :render_external_link
    config.add_show_field 'url106', :label => 'Image 106:', :helper_method => :render_external_link
    config.add_show_field 'url107', :label => 'Image 107:', :helper_method => :render_external_link
    config.add_show_field 'url108', :label => 'Image 108:', :helper_method => :render_external_link
    config.add_show_field 'url109', :label => 'Image 109:', :helper_method => :render_external_link
    config.add_show_field 'url110', :label => 'Image 110:', :helper_method => :render_external_link
    config.add_show_field 'url111', :label => 'Image 111:', :helper_method => :render_external_link
    config.add_show_field 'url112', :label => 'Image 112:', :helper_method => :render_external_link
    config.add_show_field 'url113', :label => 'Image 113:', :helper_method => :render_external_link
    config.add_show_field 'url114', :label => 'Image 114:', :helper_method => :render_external_link
    config.add_show_field 'url115', :label => 'Image 115:', :helper_method => :render_external_link
    config.add_show_field 'url116', :label => 'Image 116:', :helper_method => :render_external_link
    
     
    

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    
    config.add_search_field 'all_fields', :label => 'All Fields'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
    
    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params. 
      field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = { 
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end
    
    config.add_search_field('names') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'names' }
      field.solr_local_parameters = { 
        :qf => '$names_qf',
        :pf => '$names_pf'
      }
    end
    
    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as 
    # config[:default_solr_parameters][:qt], so isn't actually neccesary. 
    config.add_search_field('places') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'places' }
      field.qt = 'search'
      field.solr_local_parameters = { 
        :qf => '$places_qf',
        :pf => '$places_pf'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).


    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end



end 
