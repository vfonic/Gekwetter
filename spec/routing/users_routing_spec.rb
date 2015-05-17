require "rails_helper"

describe UsersController, type: :routing do
  describe "users routing" do
    it { should route(:get, '/users').to(action: :index) }
    it { should route(:get, '/vfonic').to(action: :show, id: 'vfonic') }
    it { should route(:get, '/vfonic/following').to(action: :following, id: 'vfonic') }
    it { should route(:get, '/vfonic/followers').to(action: :followers, id: 'vfonic') }
  end
end
