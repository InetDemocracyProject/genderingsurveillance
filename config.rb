
###
# Page options, layouts, aliases and proxies
###

page "/safety-app.html", :layout => "layout"

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
  # activate :asset_hash
  # activate :datasource
  # https://docs.google.com/document/d/181sIeDz16VDDvCgoXfrqbF-2lbXwt-F8hzgjn3-12DM/pub
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
  def infographic_html(image_url, target_href, target_text)
    "<div class = 'card'>
      <div class='row'>
        <div class='twelve columns center'>
          <img class='infographic-img' src=#{image_url} />
        </div>
        <div class='twelve columns center'>
          <a class='button button-primary infographic-button' href=#{target_href} target='_blank'>#{target_text}</a>
        </div>
      </div>
    </div>"
  end

  def render_infographics(html, data_sheet)
    doc = Nokogiri::HTML(html)
    data[data_sheet]['infographics'].each do |infographic|
      infographic_node = doc.at(infographic['id'])
      if infographic_node
        infographic_node.replace(infographic_html(infographic['image_url'], infographic['target_href'], infographic['target_text']))
      end
    end
    doc.to_html
  end

  def reference_indent()
    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
  end
end

# Build-specific configuration
configure :build do
  # activate :asset_hash
  # activate :datasource
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

activate :directory_indexes
