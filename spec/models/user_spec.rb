require 'spec_helper'

describe User do

  it { should respond_to(:username) }
  it { should respond_to(:name) }
  it { should respond_to(:surname) }
  it { should respond_to(:email) }

  it { should have_many(:authentications) }
  it { should have_many(:recipes) }
  it { should have_many(:opinions) }
  it { should have_many(:likes) }	
  
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email, :within => 6..100) }
  it { should validate_uniqueness_of(:email) }

end
