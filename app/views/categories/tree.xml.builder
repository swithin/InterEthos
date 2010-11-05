xml = Builder::XmlMarkup.new

xml.instruct!

xml.taxonomy(:id => @category_root_id.id, :name => @category_root_id.name) do 
	for category in Category.find_all_by_parent_id(@category_root_id, :order => "name")
	  xml.category(:id => category.id, :name => category.name) do 
		for category_1 in Category.find_all_by_parent_id(category.id, :order => "name")
		  xml.category(:id => category_1.id, :name => category_1.name) do 
			for category_2 in Category.find_all_by_parent_id(category_1.id, :order => "name")
			  xml.category(:id => category_2.id, :name => category_2.name) do 
				for category_3 in Category.find_all_by_parent_id(category_2.id, :order => "name")
				  xml.category(:id => category_3.id, :name => category_3.name) do 
					for category_4 in Category.find_all_by_parent_id(category_3.id, :order => "name")
					  xml.category(:id => category_4.id, :name => category_4.name) do 
						for category_5 in Category.find_all_by_parent_id(category_4.id, :order => "name")
						  xml.category(:id => category_5.id, :name => category_5.name) do 
							for category_6 in Category.find_all_by_parent_id(category_5.id, :order => "name")
							  xml.category(:id => category_6.id, :name => category_6.name) do 
								for category_7 in Category.find_all_by_parent_id(category_6.id, :order => "name")
								  xml.category(:id => category_7.id, :name => category_7.name) do 
								  end
								end
							  end
							end
						  end
						end
					  end
					end
				  end
				end
			  end
			end
		  end
		end
	  end
	end
end


