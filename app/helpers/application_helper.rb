module ApplicationHelper
  def redefine_url(url)
    ret = url.split("/")
    ret[2] += ".herokuapp.com"
    return ret.join("/")
  end
end
