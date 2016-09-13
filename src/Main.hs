module Main where

import Text.Read
import System.Random
import Control.Monad.State

import HigherLower.Game

main :: IO ()
main = do
  g <- createGame
--  runState (mfix play) $ asStateTIO g
  return ()
  
createGame :: IO Game
createGame = do
  low <- retryPrompt "Not a number" (promptInt "Give a lower bound")
  high <- retryPrompt "Not a number" (promptInt "Give an upper bound")
  turns <- retryPrompt "Not a number" (promptInt "How many tries do you get?")
  secret <- getStdRandom (randomR (low, high))
  return (Game (low, high) turns (Active turns))

play :: StateT Game IO () -> StateT Game IO ()
play state = do
  i <- asStateTIO $ retryPrompt "Not a number" (promptInt "How many tries do you get?")
  result <- guess i
  
  return ()

asStateTIO :: IO a -> StateT Game IO a
asStateTIO = liftIO

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
