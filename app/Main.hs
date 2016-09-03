module Main where

import           Types
import           RegexPattern
import           System.Environment
import           Data.String
import           Text.Regex.Posix
import qualified Data.Text as T (splitOn, unpack)
import           Data.Maybe
import           System.IO
import qualified System.IO as S
import           System.Process

{-
*# ADD #*
Add to Todo.txt

*# REMOVE #*
Remove from Todo.txt, but place entry in backup file todo.backup.txt

*# VIEW #*
Default. Print in readable format.

TODO: (pun not intended) Priority set for listed items, Completely edit an item.

Written by Frank Hucek
-}

todoFile :: String
todoFile = "/home/frank/bin_storage/Todo.txt"

main :: IO ()
main = do
  x <- getArgs
  mainThrow x

mainThrow :: [String] -> IO ()
mainThrow [] = viewTodoList []
mainThrow (option:xs) = do
  case option of
   "add" -> addItem xs
   "remove" -> removeItem xs
   _ -> viewTodoList xs
   -- sort

removeItem :: [String] -> IO ()
removeItem [] = putStrLn "Please specify number of item you wish to remove"
removeItem (x:_) = do
               case readMaybe x :: Maybe Int of
                Nothing -> removeItem []
                Just itemNum -> removeFromFile itemNum

addItem :: [String] -> IO ()
addItem inputItem = do
  let input = argOp inputItem =~ regexPattern :: String
  case input of
   "" -> putStrLn "Failed to match input pattern"
   _  -> appendFile todoFile (input ++ "\n")


argOp :: [String] -> String
argOp xs = init $ foldl (++) "" $ map (++ " ") xs
        -- map a space to end of each string in list
        -- concatenate list of strings into 1 string
        -- take new string - last character b/c last char is a whitespace
        -- input can now be checked against regular expression

readMaybe :: Read a => String -> Maybe a
readMaybe s = case reads s of
                  [(val, "")] -> Just val
                  _           -> Nothing

-- READ, WRITE, APPEND, REMOVE operations on file
-- File and user IO uses regex pattern. convert to Item type in program

removeFromFile :: Int -> IO ()
removeFromFile x = do
  file <- readFile todoFile
  let xs = lines file
      (a, b) = splitAt x xs
      itemList = (init a) ++ b
      items = unlines itemList
      newTodoFile = todoFile ++ ".new"
  writeFile newTodoFile items
  _ <- createProcess (proc "mv" [newTodoFile, todoFile]) -- SUPER jank, temporary fix to lazy eval here
  return ()
  -- removes indices even when typing in the wrong number

viewTodoList :: [String] -> IO ()
viewTodoList _ = do
  (_, Just hout, _, _) <- createProcess (proc "cal" []) {std_out = CreatePipe}
  cal <- hGetContents hout
  putStrLn cal
  hClose hout
  putStrLn $ "\tPRIOR.\tDESCRIPTION"
  file <- readFile todoFile
  let items = fmap (displayItem . patternToItem) $ lines file -- [String]
  printTodoList items
  --putStrLn cal

printTodoList = printTodo 1
printTodo :: Int -> [String] -> IO ()
printTodo _ [] = return ()
printTodo i (x:xs) = do
  putStrLn $ show i ++ ")\t" ++ x
  printTodo (i + 1) xs
