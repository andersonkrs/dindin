class SvgIcon
  attr_reader :name, :variant, :class_names, :path, :data_attributes

  def initialize(name, **options)
    @name = name
    @variant = options.fetch(:variant, :outline)
    @data_attributes = options.fetch(:data, {})
    @class_names = options.fetch(:class, nil)
    @path = options.fetch(:path, "icons/#{variant}/#{name}.svg")
  end

  def raw_svg
    if icon = Rails.application.assets.load_path.find(path)
      icon.content
    else
      raise ArgumentError, path
    end
  end

  def render
    doc = Nokogiri::HTML::DocumentFragment.parse(raw_svg)

    svg = doc.at("svg")
    svg.add_class("size-6") unless class_names&.include?("size-")

    if class_names.present?
      svg.add_class(class_names)
    end

    if data_attributes.present?
      data_attributes.each do |key, attr_value|
        svg.set_attribute("data-#{key.to_s.dasherize}", attr_value)
      end
    end

    doc
  end

  class << self
    def render(name, **options)
      new(name, **options).render
    end
  end
end
