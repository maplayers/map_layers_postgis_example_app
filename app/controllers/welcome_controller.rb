class WelcomeController < InheritedResources::Base

  def index
    @user = "test"
  end
  
end
