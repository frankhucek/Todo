module Main where

import           Types
import           System.Environment
import           Data.String
import           Text.Regex.Posix
import qualified Data.Text as T

{-
*# ADD #*
Add to Todo.txt

*# REMOVE #*
Remove from Todo.txt, but place entry in backup file todo.backup.txt

*# VIEW #*
Default. Print in readable format.

Written by Frank Hucek
-}

-- ideally use regular expressions to create an item
  -- input: priority:description:MM/DD/YYYY
regexPattern = "[0-9]+(:)[A-Za-z0-9 ]+(:)[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}"

main :: IO ()
main = do
  xs <- getArgs
  let input = argOp xs =~ regexPattern :: Maybe String
  case input of
   Nothing -> putStrLn "Failed to match input pattern"
   Just x -> putStrLn $ show $ patternToItem x


argOp :: [String] -> String
argOp xs = init $ foldl (++) "" $ map (++ " ") xs
        -- map a space to end of each string in list
        -- concatenate list of strings into 1 string
        -- take new string - last character b/c last char is a whitespace
        -- input can now be checked against regular expression

-- DOES NO PATTERN CHECKING - Left to regex.
-- Assumes input is of proper format
patternToItem :: String -> Item
patternToItem itemString = Item p desc date
  where list = map T.unpack $ T.splitOn (T.pack ":") (T.pack itemString)
        p    = (list !! 0) :: Int
        desc = list !! 1
        date = list !! 2
