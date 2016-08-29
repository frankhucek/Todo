module Main where

import Lib
import Types

main :: IO ()
main = do
  let x = Item {priority = 1, description = "none", date = "8/29/16"}
  putStrLn $ show x
