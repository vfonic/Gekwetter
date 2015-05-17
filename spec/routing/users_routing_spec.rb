require "rails_helper"

describe UsersController, type: :routing do
  describe "users routing" do
    it "routes to #index" do
      expect(get: "/users").to route_to("users#index")
    end

    it "routes to #show" do
      expect(get: "/vfonic").to route_to("users#show", id: "vfonic")
    end

    it "routes to #following" do
      expect(get: "/vfonic/following").to route_to("users#following", id: "vfonic")
    end

    it "routes to #followers" do
      expect(get: "/vfonic/followers").to route_to("users#followers", id: "vfonic")
    end
  end
end
