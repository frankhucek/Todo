{-# LANGUAGE OverloadedStrings #-}
module RegexPattern where

import Data.Text
import Types

-- ideally use regular expressions to create an item
  -- input: priority:description:MM/DD/YYYY
regexPattern :: String
regexPattern = "[0-9]+(:)[A-Za-z0-9 .!\"#$%()]+(:)[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}"

-- Used to read Items from file/stdin
-- DOES NO PATTERN CHECKING - Left to regex.
-- Assumes input is of proper format
patternToItem :: String -> Item
patternToItem itemString = Item (read p :: Int) desc date
  where list = Prelude.map unpack $ splitOn ":" (pack itemString)
        p    = list !! 0
        desc = list !! 1
        date = list !! 2

-- Used to write Items to a file.
itemToPattern :: Item -> String
itemToPattern (Item p desc date) = (show p) ++ ":" ++ desc ++ ":" ++ date
