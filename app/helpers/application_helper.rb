module ApplicationHelper
  def redefine_url(url)
    ret = url.split("/")
    ret[0] += "herokuapp.com"
    ret.join("/")
    ret
  end
end
