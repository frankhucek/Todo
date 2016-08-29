module Types where

data Item = Item {
  priority :: Int,
  description :: String,
  date :: String
} deriving (Show)
