pathname = Rails.root.join("config", "diametric.yml")
if pathname.file?
  require 'yaml'
  config = YAML.load(pathname.read)
  uri = config["development"]["uri"]
  Diametric::Persistence::Peer.create_database(uri)
  Diametric::Persistence::Peer.connect(uri)
  Page.create_schema.get
end
