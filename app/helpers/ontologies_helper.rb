module OntologiesHelper
  def render_tree(roots, depth=0, &block)
    roots.children.sort_by {|f| f.name}.each do | child |
      yield(child, depth)
      render_tree(child, depth+1, &block)
    end
  end
end
