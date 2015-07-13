class Card

  attr_accessor :suit,
                 :value,
                 :face

   def initialize(suit = "hearts",value = 2,face = nil)
      @suit = suit
      @value = value
      @face = face
   end
end
