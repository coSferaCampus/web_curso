# Convert a model class into symbol
def symbolize( model )
  model.to_s.tableize.singularize.to_sym
end
