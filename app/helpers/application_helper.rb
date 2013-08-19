module ApplicationHelper
def render_external_link args, results = Array.new
		text = args[:document].get(blacklight_config.show_fields[args[:field]][:text])
        url = args[:document].get(args[:field])
        link_text = args[:document].get(args[:field])
        results << link_to(link_text, url, { :target => "_blank" }).html_safe
  end
end
