module FixExperiments where

fx :: Int -> Maybe Int
fx i
  | i > 0 = Just (i-1)
  | otherwise = Nothing
