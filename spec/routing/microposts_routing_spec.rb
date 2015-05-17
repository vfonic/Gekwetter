require "rails_helper"

describe MicropostsController, type: :controller do
  describe "microposts routing" do
    it "routes to #create" do
      expect(post: '/vfonic/microposts').to route_to('microposts#create', user_id: 'vfonic')
    end

    it "routes to #destroy" do
      expect(delete: '/vfonic/microposts/1').to route_to('microposts#destroy', user_id: 'vfonic', id: '1')
    end
  end
end
