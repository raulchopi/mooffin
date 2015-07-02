module ApplicationHelper

	def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? content_for(:title) + " | Mooffin" : "Mooffin - Buscador de recetas sociales por ingredientes"
    end
  end

	def flash_class(level)
		case level
			when :notice then "alert alert-info"
			when :success then "alert alert-success"
			when :error then "alert alert-error"
			when :alert then "alert alert-block"
			else "alert #{level}"
		end
	end
end
