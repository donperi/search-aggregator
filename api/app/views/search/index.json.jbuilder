json.items @result.items do |node|
  json.title node.title
  json.description node.description
  json.url node.url
  json.source node.source
end

json.total @result.total
