module HigherLower where

data Status = Won | Lost | Active { turns :: Int } deriving (Show, Eq)

data Game = Game
            { bounds :: (Int, Int)
            , secret :: Int
            , status :: Status
            } deriving (Show)

guess :: Game -> Int -> (Maybe Ordering, Game)
guess g@(Game (l, u) number status) i
  | status == Lost = (Nothing, g)
  | status == Lost = (Nothing, g)
  | otherwise =
    let
      result = compare i number
      nextStatus = newStatus status result
      nextBounds = case result of
        EQ -> (l, u)
        LT -> (i, u)
        GT -> (l, i)
    in (Just result, Game nextBounds number nextStatus)

isActive :: Status -> Bool
isActive (Active _) = True
isActive _ = False

newStatus :: Status -> Ordering -> Status
newStatus (Active i) EQ
  | i >= 0 = Won
  | otherwise = Lost
newStatus (Active 0) _ = Lost
newStatus (Active i) _ = Active (i - 1)
