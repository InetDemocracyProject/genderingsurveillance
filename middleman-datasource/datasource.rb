class DataSource < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    puts "hello"
    super
  end
  alias :included :registered
end

::Middleman::Extensions.register(:datasource, DataSource)
