# Require core library
require 'middleman-core'
require 'net/http'
require "google_drive"
require 'nokogiri'
require 'htmlentities'

# Extension namespace
class DataSource < ::Middleman::Extension
  expose_to_template :google_doc

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super
  end

  def google_doc(id)
    session = GoogleDrive::Session.from_config("client_secret.json")
    file = session.file_by_url("https://docs.google.com/document/d/#{id}/pub")
    html = file.export_as_string('text/html')
    # coder = HTMLEntities.new
    # doc = Nokogiri::HTML(coder.decode(html))
    doc = Nokogiri::HTML(html)
    # doc.xpath('//@style').remove
    doc.xpath('//@*').remove
    spans = doc.search("span")
    spans.each {|span| span.replace(span.content)}
    doc.at('body').children.to_html
  end

end

::Middleman::Extensions.register(:datasource, DataSource)
