module Main where

import qualified Markup
import qualified Html
import Convert (convert)

import System.Directory (doesFileExist)
import System.Environment (getArgs)

main :: IO ()
main =
  getArgs >>= \args ->
    case args of
      [] ->
        getContents >>= \content ->
          putStrLn $ process "Empty title" content

      [input, output] ->
        readFile input >>= \content ->
        doesFileExist output >>= \exists ->
            let
              writeResult = writeFile output $ process input content
            in
              if exists
                then whenIO confirm writeResult
                else writeResult

      _ ->
        putStrLn "Usage: runghc Main.hs [-- <input-file> <output-file>]"

confirm :: IO Bool
confirm =
  putStrLn "Are you sure? (y/n)" *>
    getLine >>= \answer ->
      case answer of
        "y" -> pure True
        "n" -> pure False
        _ -> putStrLn "Invalid response. Use y or n" *>
          confirm

whenIO :: IO Bool -> IO () -> IO ()
whenIO cond action =
  cond >>= \result ->
    if result
      then action
      else pure ()

process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse

