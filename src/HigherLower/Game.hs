module HigherLower.Game where

import Control.Monad.State

data Status = Won | Lost | Active { turns :: Int } deriving (Show, Eq)

data Game = Game
            { bounds :: (Int, Int)
            , secret :: Int
            , status :: Status
            } deriving (Show)

checkGuess :: (Monad m) => Int -> StateT Game m (Maybe Ordering)
checkGuess i = do
  g <- get
  case g of
    (Game b_ _ Lost) -> return Nothing
    (Game _ _ Won) -> return Nothing
    (Game bounds secret status) ->
      let
        result = compare i secret
        nextBounds = newBounds bounds secret result
        nextStatus = newStatus status result
      in do
        put $ Game nextBounds secret nextStatus
        return $ Just result

        
    
      
--checkGuess i = state step
--  where
--    step g@(Game (l, u) secret status)
--      | status == Lost = (Nothing, g)
--      | status == Won = (Nothing, g)
--      | otherwise = (Just result, Game nextBounds secret nextStatus)
--      where
--        result = compare i secret
--        nextBounds = case result of
--          EQ -> (l, u)
--          LT -> (i, u)
--          GT -> (l, i)
--        nextStatus = newStatus status result

newBounds :: (Int, Int) -> Int -> Ordering -> (Int, Int)
newBounds (l, u) i o
  | o == EQ = (i, i)
  | o == LT = (i, u)
  | o == GT = (l, i)

newStatus :: Status -> Ordering -> Status
newStatus (Active i) EQ
  | i >= 0 = Won
  | otherwise = Lost
newStatus (Active 0) _ = Lost
newStatus (Active i) _ = Active (i - 1)
newStatus oldState _ = oldState
