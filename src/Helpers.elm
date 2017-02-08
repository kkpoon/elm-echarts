module Helpers exposing (..)

import Json.Encode exposing (Value, string, float, int, bool)


toValueList : (a -> Value) -> String -> Maybe a -> List ( String, Value )
toValueList wrapper key data =
    case data of
        Just d ->
            [ ( key, wrapper d ) ]

        Nothing ->
            []


toStringValueList : String -> Maybe String -> List ( String, Value )
toStringValueList =
    toValueList string


toFloatValueList : String -> Maybe Float -> List ( String, Value )
toFloatValueList =
    toValueList float


toIntValueList : String -> Maybe Int -> List ( String, Value )
toIntValueList =
    toValueList int


toBoolValueList : String -> Maybe Bool -> List ( String, Value )
toBoolValueList =
    toValueList bool
