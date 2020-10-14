require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /static_pages" do
    it "topページのリクエストが成功すること" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
