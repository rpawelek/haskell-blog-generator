main :: IO ()
main = do
  putStrLn "TODO app"
  let initialList = []
  interactWithUser initialList
  putStrLn "Thanks for using this app."

-- Takes a list of items
-- Interact with the user
interactWithUser :: Items -> IO ()
interactWithUser items = do
  line <- getLine
  case parseCommand line of
    Right DisplayItems -> do
      putStrLn "The List of items is:"
      putStrLn (displayItems items)
      interactWithUser items

    Right (AddItem item) -> do
      let newItems = addItem item items
      putStrLn "Item added."
      interactWithUser newItems

    Right Quit -> do
      putStrLn "Bye!"
      pure ()

    Right Help -> do
      putStrLn "Commands: help, quit, items, add - <item to add>"
      interactWithUser items

    Right (Done index) -> do
      let result = removeItem index items
      case result of
        Left errMsg -> do
          putStrLn ("Error: " ++ errMsg)
          interactWithUser items
        Right newItems -> do
          putStrLn "Item done."
          interactWithUser newItems

    Left errMsg -> do
      putStrLn ("Error: " ++ errMsg)
      interactWithUser items

data Command
  = Quit
  | DisplayItems
  | AddItem String
  | Help
  | Done Int

parseCommand :: String -> Either String Command
parseCommand line = case words line of
  ["quit"] -> Right Quit
  ["items"] -> Right DisplayItems
  "add" : "-" : item -> Right (AddItem (unwords item))
  ["help"] -> Right Help
  ["done", idxStr] ->
    if all (\c -> elem c "0123456789") idxStr
      then Right (Done (read idxStr))
      else Left "Invalid index."
  _ -> Left "Unknown command."


type Item = String
type Items = [String]

-- Returns a new list of Items with the new item in it
addItem :: Item -> Items -> Items
addItem item items = item : items

-- Returns a string representation of the items
displayItems :: Items -> String
displayItems items =
  let
    displayItem index item = show index ++ " - " ++ item
    reversedList = reverse items
    displayedItemsList = zipWith displayItem [1..] reversedList
  in
    unlines displayedItemsList

-- Returns a new list of items or an error message if the index is out of bounds
removeItem :: Int -> Items -> Either String Items
removeItem reverseIndex allItems =
    impl (length allItems - reverseIndex) allItems
  where
    impl index items =
      case (index, items) of
        (0, item : rest) ->
          Right rest
        (n, []) ->
          Left "Index out of bounds."
        (n, item : rest) ->
          case impl (n - 1) rest of
            Right newItems ->
              Right (item : newItems)
            Left errMsg ->
              Left errMsg

