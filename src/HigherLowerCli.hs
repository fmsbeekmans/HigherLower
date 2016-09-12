module HigherLowerCli where

import Text.Read

createGame :: IO (Int, Int)
createGame = do
  low <- retryPrompt "Not a number" (promptInt "Give a lower bound")
  high <- retryPrompt "Notf a number" (promptInt "Give an upper bound")
  return (low, high)

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
