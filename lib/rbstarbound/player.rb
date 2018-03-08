# frozen_string_literal: true

module RBStarbound
  module Player
    DATA_NAME = 'PlayerEntity'
    DATA_VERSION = 30
    Data = Struct.new(:name, :version, :data) do
      def player_name; data['identity']['name'];               end
      def player_name=(name); data['identity']['name'] = name; end
      def gender; data['identity']['gender'];                  end
      def gender=(value); data['identity']['gender'] = value;  end
      def hair_type; data['identity']['hairType'];               end
      def hair_type=(type); data['identity']['hairType'] = type; end
      def personality; data['identity']['personalityIdle'];                 end
      def personality=(value); data['identity']['personalityIdle'] = value; end
      def death_count; data['identity']['deathCount'];                      end
      def death_count=(count); data['identity']['deathCount'] = count;      end
      def play_time; data['identity']['playTime']; end
      def uuid; data['identity']['uuid'];          end
      def intro_complete?; data['identity']['introComplete'];              end
      def intro_complete=(bool); data['identity']['introComplete'] = bool; end
      def ship_level; data['identity']['shipLevel'];                 end
      def ship_level=(level); data['identity']['shipLevel'] = level; end
    end
  end
end
