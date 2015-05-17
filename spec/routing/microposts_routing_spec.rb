require "rails_helper"

describe MicropostsController, type: :controller do
  describe "microposts routing" do
    it { should route(:post, '/vfonic/microposts').to(action: :create, user_id: 'vfonic') }
    it { should route(:delete, '/vfonic/microposts/1').to(action: :destroy, user_id: 'vfonic', id: '1') }
  end
end
