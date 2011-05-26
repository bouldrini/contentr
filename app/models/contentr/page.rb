# coding: utf-8

module Contentr
  class Page < Node

    # Fields
    field :description, :type => String
    field :layout,      :type => String, :default => 'default'
    field :template,    :type => String, :default => 'default'
    field :linked_to,   :type => String, :index => true
    field :menu_title,  :type => String
    field :hidden,      :type => Boolean, :default => false, :index => true
    field :published,   :type => Boolean, :default => false, :index => true

    # Relations
    embeds_many :paragraphs, :class_name => 'Contentr::Paragraph'

    # Protect attributes from mass assignment
    attr_accessible :description, :layout, :template, :linked_to, :hidden

    # Validations
    validates_presence_of   :layout
    validates_presence_of   :template
    validates_uniqueness_of :linked_to, :allow_nil => true, :allow_blank => true


    def self.find_by_controller_action(controller, action)
      page = Contentr::Page.where(:linked_to => "#{controller}/#{action}").try(:first)

      # Try wildcard match on the action if a previous match failed
      if page.blank?
        page = Contentr::Page.where(:linked_to => "#{controller}/*").try(:first)
      end

      # return page
      page if page and page.visible?
    end

    def is_link?
      self.linked_to.present?
    end

    def controller_action_url_options
      if self.is_link?
        p          = self.linked_to.split('/')
        action     = p.last
        action     = 'index' if action.blank? or action.strip == '*'
        controller = p.slice(0..p.size-2).join('/')
        controller = "/#{controller}" unless controller.include?('/')

        {:controller => controller, :action => action}
      end
    end

    def expected_areas
      self.paragraphs.map(&:area_name).uniq
    end

    def paragraphs_for_area(area_name)
      self.paragraphs.where(area_name: area_name)
    end

    def publish!
      self.update_attribute(:published, true)
    end

    def visible?
      self.published? and not self.hidden?
    end

    def visible_children
      self.children.collect{|p| p if p.visible?}.compact
    end

  end
end
