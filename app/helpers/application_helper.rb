module ApplicationHelper
	def error_field(model, attribute)
		if model.errors.has_key? attribute
			content_tag(
				:span,
				model.errors[attribute].first,
                class: "erro"
			)
		end
	end
end
