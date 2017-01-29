require "middleman-core"

Middleman::Extensions.register :middleman-datasource do
  require "my-extension/extension"
  DataSource
end
