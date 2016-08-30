module Types where

data Item = Item {
  priority :: Int,
  description :: String,
  date :: String
} deriving (Show)

displayItem :: Item -> String
displayItem (Item x y z) = show x ++ "\t" ++ y ++ "\tDUE: " ++ z

quickItemSort :: [Item] -> [Item]
quickItemSort [] = []
quickItemSort (x:xs) = quickItemSort [ a | a <- xs, priority a <= priority x ] -- <=
                       ++ [x]
                       ++ quickItemSort [a | a <- xs, priority a > priority x] -- >


adjustItemPriority :: Item -> Int -> Item
adjustItemPriority (Item _ x y) newPriority = Item newPriority x y
