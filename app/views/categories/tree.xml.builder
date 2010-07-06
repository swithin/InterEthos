xml = Builder::XmlMarkup.new

xml.instruct!

xml.taxonomy(:id => @category_root_id.id, :name => @category_root_id.name) do 
	for category in Category.find_all_by_parent_id(@category_root_id, :order => "name")
	  xml.category do
		xml.name(category.name)
		xml.parent_id(category.parent_id)
		xml.id(category.id)
		render_tree(category) do |branch|
		  # xml.branch do
		  xml.branch(:indent=>branch[1]) do 
			xml.parent_id(branch[0].parent_id)
			xml.name(branch[0].name)
			xml.id(branch[0].id)
			xml.level(branch[1])
			# xml.quantity(1)
		  end
		end
	  end
	end
end


# xml.parent_id(branch[0].parent_id)
# xml.name(branch[0].name)
# xml.id(branch[0].id)
# xml.level(branch[1])
# xml.quantity(1)

# xml.taxonomy(:code => "George") do 
  # xml.categories do
    # @categories.each do |category| 
      # xml.category do
        # xml.parent_id(category.parent_id)
        # xml.quantity(1)
      # end
    # end
  # end 
# end