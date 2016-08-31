module Main where

import           Types
import           RegexPattern
import           System.Environment
import           Data.String
import           Text.Regex.Posix
import qualified Data.Text as T (splitOn, unpack)
import           Data.Maybe

{-
*# ADD #*
Add to Todo.txt

*# REMOVE #*
Remove from Todo.txt, but place entry in backup file todo.backup.txt

*# VIEW #*
Default. Print in readable format.

Written by Frank Hucek
-}

main :: IO ()
main = do
  xs <- getArgs
  let input = argOp xs =~ regexPattern :: String
  case input of
   "" -> putStrLn "Failed to match input pattern"
   _ -> putStrLn $ show $ patternToItem $ input


argOp :: [String] -> String
argOp xs = init $ foldl (++) "" $ map (++ " ") xs
        -- map a space to end of each string in list
        -- concatenate list of strings into 1 string
        -- take new string - last character b/c last char is a whitespace
        -- input can now be checked against regular expression
