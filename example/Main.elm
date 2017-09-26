module Main exposing (..)

import Html exposing (Html, text)
import Example


main : Html msg
main =
    Html.div []
        [ Example.pie
        , Example.bar
        ]
