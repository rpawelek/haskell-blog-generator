data Move = Rock | Paper | Scissors
    deriving (Eq, Read, Show, Enum, Bounded)

data Outcome = Lose | Tie | Win
    deriving (Show, Eq, Ord)

outcome :: Move -> Move -> Outcome
outcome Rock Scissors = Win
outcome Paper Rock = Win
outcome Scissors Paper = Win
outcome player opponent =
  if player == opponent
    then Tie
    else Lose

parseMove :: String -> Maybe Move
parseMove str | [(m, rest)] <- reads str, ok rest = Just m
              | otherwise                         = Nothing
  where ok = all (`elem` " \t\r\n")

