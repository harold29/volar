# frozen_string_literal: true

module HelperMethods
  def render_custom_response(file_name, locals = {})
    template_path = Rails.root.join('spec', 'fixtures', file_name)
    erb_template = File.read(template_path)
    ERB.new(erb_template).result(binding)
  end
end
