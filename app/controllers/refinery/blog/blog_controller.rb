module Refinery
  module Blog
    class BlogController < ::ApplicationController

      include ControllerHelper

      helper :'refinery/blog/posts'
      before_filter :find_page, :find_all_blog_categories

      protected

        def find_page
          @page = Refinery::Page.find_by_link_url(Refinery::Blog.page_url)
        end

        def render_with_templates?(render_options = {})
          if Refinery::Pages.use_layout_templates && @page.layout_template.present?
            render_options[:layout] = @page.layout_template
          end
          if Refinery::Pages.use_view_templates && @page.view_template.present?
            render_options[:action] = @page.view_template
          end
          render render_options if render_options.any?
        end
    end
  end
end
