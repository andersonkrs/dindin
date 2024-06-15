class SvgIcon
  attr_reader :name, :variant, :class_names, :path

  def initialize(name, **options)
    @name = name
    @variant = options.fetch(:variant, :outline)
    @class_names = options.fetch(:class, nil)
    @path = options.fetch(:path, "icons/#{variant}/#{name}.svg")
  end

  def raw_svg = Rails.application.assets.load_path.find(path).content

  def render
    doc = Nokogiri::HTML::DocumentFragment.parse(raw_svg)

    svg = doc.at("svg")
    svg.set_attribute("stroke", "currentColor")
    svg.set_attribute("stroke-width", "1.5")
    svg.add_class("size-6")

    if class_names
      svg.add_class(class_names)
    end

    doc
  end

  class << self
    def render(name, **options)
      new(name, **options).render
    end
  end
end
