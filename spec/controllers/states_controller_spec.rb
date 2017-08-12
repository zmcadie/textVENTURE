require 'rails_helper'

RSpec.describe StatesController, type: :controller do
  describe 'clean_user_input function' do
    it 'strips away leading and trailing whitespace' do
      input = " d'oh "
      expect(controller.clean_user_input(input)).to eql ("d'oh")
    end

    it 'translates input to downcase' do
      input = "NED FlAndErs"
      expect(controller.clean_user_input(input)).to eql ("ned flanders")
    end

    it 'removes any extra spaces between words' do
      input = "nothing    at  all nothing at all"
      expect(controller.clean_user_input(input)).to eql ("nothing at all nothing at all")
    end
  end
  describe 'action_helper function' do
    it 'lists available actions for current state' do
    end
  end
end
