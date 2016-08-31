module Types where

-- idea: maybe think of our item type as a monad?

data Item = Item {
  priority :: Int,
  description :: String,
  date :: String
} deriving (Show, Read)

displayItem :: Item -> String
displayItem (Item x y z) = show x ++ "\t" ++ y ++ "\tDUE: " ++ z

quickItemSort :: [Item] -> [Item]
quickItemSort [] = []
quickItemSort (x:xs) = quickItemSort [ a | a <- xs, priority a <= priority x ] -- <=
                       ++ [x]
                       ++ quickItemSort [a | a <- xs, priority a > priority x] -- >


adjustItemPriority :: Item -> Int -> Item
adjustItemPriority (Item _ x y) newPriority = Item newPriority x y
