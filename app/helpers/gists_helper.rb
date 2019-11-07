module GistsHelper
  def gist_title(gist)
    truncate(gist.question.body, length: 25)
  end

  def gist_hash(gist)
    gist.url.split("/").last
  end
end
