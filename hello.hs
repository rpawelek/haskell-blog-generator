import Html

main :: IO ()
main = putStrLn (render myhtml)

myhtml :: Html
myhtml =
  html_
    "<My title>'&"
    ( append_
      (h1_ "Heading")
      ( append_
       (p_ "Paragraph")
       ( append_ 
        (ul_
          [ p_ "item 1"
          , p_ "item 2"
          , p_ "item 3"
          ])
        (ol_
          [ code_ "item 4 (code)"
          , code_ "item 5 (code)"
          , p_ "item 6"
          ])
       )
      )
    )

