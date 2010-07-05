# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # From http://www.valibuk.net/?p=57
  # This is leveraging the prototype JavaScript library, which
  # comes with Rails. See views/layouts/application.rhtml to see where
  # this is loaded.
  
  def bg_for_highlights
      "#FFE495"
  end
  
  def indent 
      indent = "&nbsp;&nbsp;&nbsp;&nbsp;"
  end

  def set_focus(id)
    javascript_tag("$('#{id}').focus()")
  end
  
  def tree_select(categories, model, name, selected=0, level=0, init=true)
    html = ""
    # The "Root" option is added
    # so the user can choose a parent_id of 0
    if init
        # Add "Root" to the options
        html << "<select name=\"#{model}[#{name}]\" id=\"#{model}_#{name}\">\n"
        html << "\t<option value=\"1\""
        if name == 'category_id'
            html << " selected=\"selected\"" if selected.id == 0
        else
            html << " selected=\"selected\"" if selected.parent_id == 0
        end
        html << ">Root</option>\n"
    end

    if categories.length > 0
      level += 1 # keep position
      categories.collect do |rlm|
        # if name == 'category_id'
            # html << "\t<option value=\"#{rlm.id}\" style=\"padding-left:#{level * 10}px\""
            # html << ' selected="selected"' if rlm.id == selected.id
        # else
            html << "\t<option value=\"#{rlm.id}\" style=\"padding-left:#{level * 10}px\""
            html << ' selected="selected"' if rlm.id == selected.id
            html << ' selected="selected"' if rlm.id == @parent_id
        # end
        html << ">#{rlm.name}</option>\n"
        html << tree_select(rlm.children, model, name, selected, level, false)
      end
    end
    html << "</select>\n" if init
    return html
  end
end