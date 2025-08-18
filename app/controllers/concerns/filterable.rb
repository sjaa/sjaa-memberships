
module Filterable
  extend ActiveSupport::Concern

  def and_or_helper(model, query, operation, field, list)
    list.select!{|l| l.present?}
    return query if(list.empty?)
    query = query.joins(field)
    
    if(operation != 'and')
      query = query.where(field => {id: list})
    else
      # Yucky rendering out all the people, but what else to do?
      _models = model.where(id: query.map(&:id).uniq).includes(field)
      _models = _models.select{|p| (list.map(&:to_i) - p.association(field).reader.map(&:id)).empty?}
      query = model.where(id: _models.map(&:id))
      
      # Alternative but relies on grouping
      #query = query.where(field => {id: list}).group(:id).having("COUNT(#{field}.id) >= ?", list.size)
    end
    
    return query
  end
end