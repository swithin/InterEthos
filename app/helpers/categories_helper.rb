module CategoriesHelper
  def render_tree(roots, depth=0, &block)
    roots.children.sort_by {|f| f.name}.each do | child |
      yield(child, depth)
      render_tree(child, depth+1, &block)
    end
  end
  
  # def bird_nests=(params)
    # bird_nest=params[:bird_nest] 
    # if !bird_nest.nil?
      # if bird_nest.class==Array
        # bird_nest.each do |attrs|
          # bird_nests.build(attrs)
        # end
      # else 
        # bird_nests.build(bird_nest)
      # end
    # end
end