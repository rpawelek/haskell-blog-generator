import Data.Word (Word8)
import Data.Maybe (listToMaybe)
import Html
import Markup

main :: IO ()
main = putStrLn (render myhtml)

myhtml :: Html
myhtml =
  html_
    "<My title>'&"
    (
     h1_ "Heading"
      <> p_ "Paragraph"
      <> ul_ [ p_ "item 1"
             , p_ "item 2"
             , p_ "item 3"
             ]
      <> ol_ [ p_ "item 4"
             , p_ "item 5"
             , p_ "item 6"
             ]
      <> code_ "code"
    )

myDocument :: Document
myDocument =
  [ Heading 1 "Compiling programs with ghc"
  , Paragraph ">Running ghc invokes the Glasgow Haskell Compiler (GHC), and can be used to compile Haskell modules and programs into native executables and libraries."
  , Paragraph "Create a new Haskell source file named hello.hs, and write the following code in it:"
  , CodeBlock ["main = putStrLn \"Hello, Haskell!\""]
  , Paragraph "Now, we can compile the program by invoking ghc with the file name:"
  , CodeBlock
      [ "➜ ghc hello.hs"
      , "[1 of 1] Compiling Main             ( hello.hs, hello.o )"
      , "Linking hello ..."
      ]
  , Paragraph "GHC created the following files:"
  , UnorderedList
      [ "hello.hi - Haskell interface file"
      , "hello.o - Object file, the output of the compiler before linking"
      , "hello (or hello.exe on Microsoft Windows) - A native runnable executable."
      ]
  , Paragraph "GHC will produce an executable when the source file satisfies both conditions:"
  , OrderedList
      [ "Defines the main function in the source file"
      , "Defines the module name to be Main or does not have a module declaration"
      ]
  , Paragraph "Otherwise, it will only produce the .o and .hi files."
  ]

replicate' :: Int -> a -> [a]
replicate' n x =
  if n <= 0
    then []
  else
    x : replicate (n - 1) x

even' :: Int -> Bool
even' x =
  if x == 0
    then True
  else
    odd' (x - 1)

odd' :: Int -> Bool
odd' x =
  if x == 0
    then False
  else
    even' (x - 1)

-- 4.4
data Color
  = RGB Word8 Word8 Word8

data Brightness
  = Dark
  | Bright

data EightColor
  = Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White

data AnsiColor
  = AnsiColor Brightness EightColor

isBright :: AnsiColor -> Bool
isBright ansicolor =
  case ansicolor of
    AnsiColor Dark _ -> False
    AnsiColor Bright _ -> True

ansiToUbuntu :: AnsiColor -> Color
ansiToUbuntu ansicolor =
  case ansicolor of
    AnsiColor Dark Black ->
      RGB 1 1 1
    AnsiColor Bright Black ->
      RGB 128 128 128
    AnsiColor Dark Red ->
      RGB 222 56 43
    AnsiColor Bright Red ->
      RGB 255 0 0
    AnsiColor Dark Green ->
      RGB 57 181 74
    AnsiColor Bright Green ->
      RGB 0 255 0
    AnsiColor Dark Yellow ->
      RGB 255 199 6
    AnsiColor Bright Yellow ->
      RGB 255 255 0
    AnsiColor Dark Blue ->
      RGB 0 111 184
    AnsiColor Bright Blue ->
      RGB 0 0 255
    AnsiColor Dark Magenta ->
      RGB 118 38 113
    AnsiColor Bright Magenta ->
      RGB 255 0 255
    AnsiColor Dark Cyan ->
      RGB 44 181 233
    AnsiColor Bright Cyan ->
      RGB 0 255 255
    AnsiColor Dark White ->
      RGB 204 204 204
    AnsiColor Bright White ->
      RGB 255 255 255

isEmpty :: [a] -> Bool
isEmpty xs =
  case listToMaybe xs of
    Nothing -> True
    Just _ -> False

isEmpty' :: [a] -> Bool
isEmpty' xs =
  case xs of
    [] -> True
    _ : _ -> False
