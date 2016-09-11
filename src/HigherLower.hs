module HigherLower where

data Status = Won | Lost | Active { turns :: Int } deriving (Show, Eq)

data Game = Game
            { secret :: Int
            , status :: Status
            } deriving (Show)

guess :: Game -> Int -> (Maybe Ordering, Game)
guess g@(Game number status) i
  | status == Lost = (Nothing, g)
  | status == Lost = (Nothing, g)
  | otherwise = let result = compare i number
                in (Just result, Game number $ newStatus status result)

isActive :: Status -> Bool
isActive (Active _) = True
isActive _ = False

newStatus :: Status -> Ordering -> Status
newStatus (Active i) EQ
  | i >= 0 = Won
  | otherwise = Lost
newStatus (Active 0) _ = Lost
newStatus (Active i) _ = Active (i - 1)
