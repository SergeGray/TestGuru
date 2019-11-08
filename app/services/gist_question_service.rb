class GistQuestionService
  def initialize(question, client: default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    response = Struct.new(:gist) do
      def success?
        gist.key?(:html_url)
      end

      def url
        gist[:html_url]
      end
    end

    response[@client.create_gist(gist_params)]
  end

  private

  def default_client
    GithubClient.new
  end

  def gist_params
    {
      description: I18n.t('.description', title: @test.title),
      files: {
        "test-guru-question.txt" => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
