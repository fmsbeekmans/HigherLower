module HigherLower.Game where

import Control.Monad.State

data Status = Won | Lost | Active { turns :: Int } deriving (Show, Eq)

data Game = Game
            { bounds :: (Int, Int)
            , secret :: Int
            , status :: Status
            } deriving (Show)

checkGuess :: (Monad m) => Int -> StateT Game m (Maybe Ordering)
checkGuess i = state step
  where
    step g@(Game (l, u) secret status)
      | status == Lost = (Nothing, g)
      | status == Won = (Nothing, g)
      | otherwise = (Just result, Game nextBounds secret nextStatus)
      where
        result = compare i secret
        nextBounds = case result of
          EQ -> (l, u)
          LT -> (i, u)
          GT -> (l, i)
        nextStatus = newStatus status result

newStatus :: Status -> Ordering -> Status
newStatus (Active i) EQ
  | i >= 0 = Won
  | otherwise = Lost
newStatus (Active 0) _ = Lost
newStatus (Active i) _ = Active (i - 1)
newStatus oldState _ = oldState
