module Main where

import Text.Read
import System.Random
import Control.Monad.State

import HigherLower.Game

main :: IO ()
main = do
  g <- createGame
  evalStateT playGame g
  
createGame :: IO Game
createGame = do
  low <- retryPrompt "Not a number" (promptInt "Give a lower bound")
  high <- retryPrompt "Not a number" (promptInt "Give an upper bound")
  turns <- retryPrompt "Not a number" (promptInt "How many tries do you get?")
  secret <- getStdRandom (randomR (low, high))
  return (Game (low, high) secret (Active turns))

playGame :: StateT Game IO ()
playGame = do
  i <- liftIO $ retryPrompt "Not a number" (promptInt "Your guess:")
  result <- checkGuess i
  case result of
   Nothing -> liftIO (putStrLn "This game was already played.")
   Just r -> do
     case r of
       LT -> liftIO (putStrLn "Getting closer; your guess was too low.") >> playGame
       GT -> liftIO (putStrLn "Getting closer; your guess was too high.") >> playGame
       EQ -> liftIO (putStrLn "YOU WIN!")
       
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