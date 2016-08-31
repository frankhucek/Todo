module Main where

import Types
import System.Environment
import Data.String

{-
*# ADD #*
Add to Todo.txt

*# REMOVE #*
Remove from Todo.txt, but place entry in backup file todo.backup.txt

*# VIEW #*
Default. Print in readable format.
-}


main :: IO ()
main = do
  xs <- getArgs
  -- case x of
  --     "add"
  let x = init $ foldl (++) "" $ fmap (++ " ") xs -- tail $ init to remove \" from input
      -- itm = (read "Item {priority=0, description=\"NA\", date=\"8/30/16\"}" :: Item)
      -- write func to insert space before '{' and after each ','
      itm = (read x :: Item)
  putStrLn $ displayItem itm


-- ideally use regular expressions to create an item
  -- input: priority:description:MM/DD/YYYY
