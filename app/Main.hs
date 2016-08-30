module Main where

import Types
import System.Environment

main :: IO ()
main = do
  (x:_) <- getArgs
  case x of
      "add"
