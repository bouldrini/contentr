# coding: utf-8

module MmCms::Liquid::Filters::Url

  def url(source)
    return "/cms/#{source}" # FIXME: Do not hardcode the /cms prefix
  end

end

Liquid::Template.register_filter(MmCms::Liquid::Filters::Url)