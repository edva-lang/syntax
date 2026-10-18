module QuickSort (quicksort, partitionBy) where

-- Classic functional quicksort with list comprehension
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smaller = quicksort [a | a <- xs, a <= x]
        bigger  = quicksort [a | a <- xs, a > x]
    in  smaller ++ [x] ++ bigger

partitionBy :: (a -> Bool) -> [a] -> ([a], [a])
partitionBy _ [] = ([], [])
partitionBy p (x:xs)
    | p x       = (x : yes, no)
    | otherwise = (yes, x : no)
    where (yes, no) = partitionBy p xs
