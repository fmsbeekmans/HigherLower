module Main where

import Text.Read
import System.Random

import HigherLower.Game

main :: IO ()
main = do
  g <- createGame
  return ()
  
createGame :: IO Game
createGame = do
  low <- retryPrompt "Not a number" (promptInt "Give a lower bound")
  high <- retryPrompt "Not a number" (promptInt "Give an upper bound")
  turns <- retryPrompt "Not a number" (promptInt "How many tries do you get?")
  secret <- getStdRandom (randomR (low, high))
  return (Game (low, high) turns (Active turns))

play :: Int -> StateT Game IO ()
    
promptInt :: String ->  IO (Maybe Int)
promptInt q = do
  putStrLn q
  readMaybe <$> getLine

retryPrompt :: String -> IO (Maybe a) -> IO a
retryPrompt f p = do
  res <- p
  case res of
    Just x -> return x
    Nothing -> do
      putStrLn f
      retryPrompt f p
