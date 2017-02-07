module ECharts exposing (..)

{-|

# Converter
@docs toJsonString

# Chart Types
@docs ChartType

# Chart Options
@docs PieChartOption

# Series
@docs PieSeries

# Option Attribute Types
@docs Orientation
-}

import Json.Encode exposing (encode, object, string, int, float, list)


{-| describe the orientation attribute
-}
type Orientation
    = Horizontal
    | Vertical


{-| describe the data series of pie chart
-}
type alias PieSeries =
    { name : String
    , radius : ( String, String )
    , center : ( String, String )
    , data : List { value : Float, name : String }
    , itemStyle :
        { emphasis :
            { shadowBlur : Int
            , shadowOffsetX : Int
            , shadowColor : String
            }
        }
    }


{-| describe the chart option of pie chart
-}
type alias PieChartOption =
    { title :
        { text : String
        , subtext : String
        , left : String
        }
    , tooltip :
        { formatter : String
        }
    , legend :
        { orient : Orientation
        , left : String
        , data : List String
        }
    , series : List PieSeries
    }


{-| the chart type
-}
type ChartType
    = PieChart PieChartOption


{-| convert the chart option to a string of json
-}
toJsonString : ChartType -> String
toJsonString chart =
    let
        mapData data =
            object
                [ ( "name", string data.name )
                , ( "value", float data.value )
                ]

        mapPieSeries series =
            object
                [ ( "name", string series.name )
                , ( "type", string "pie" )
                , ( "radius"
                  , list
                        [ string <| Tuple.first series.radius
                        , string <| Tuple.second series.radius
                        ]
                  )
                , ( "center"
                  , list
                        [ string <| Tuple.first series.center
                        , string <| Tuple.second series.center
                        ]
                  )
                , ( "data", list <| List.map mapData series.data )
                , ( "itemStyle"
                  , object
                        [ ( "emphasis"
                          , object
                                [ ( "shadowBlur", int series.itemStyle.emphasis.shadowBlur )
                                , ( "shadowOffsetX", int series.itemStyle.emphasis.shadowOffsetX )
                                , ( "shadowColor", string series.itemStyle.emphasis.shadowColor )
                                ]
                          )
                        ]
                  )
                ]
    in
        encode 0 <|
            case chart of
                PieChart option ->
                    object
                        [ ( "title"
                          , object
                                [ ( "text", string option.title.text )
                                , ( "subtext", string option.title.subtext )
                                , ( "left", string option.title.left )
                                ]
                          )
                        , ( "tooltip"
                          , object
                                [ ( "trigger", string "item" )
                                , ( "formatter", string option.tooltip.formatter )
                                ]
                          )
                        , ( "legend"
                          , object
                                [ ( "orient"
                                  , string
                                        (case option.legend.orient of
                                            Horizontal ->
                                                "horizontal"

                                            Vertical ->
                                                "vertical"
                                        )
                                  )
                                , ( "left", string option.legend.left )
                                , ( "data"
                                  , list <|
                                        List.map string option.legend.data
                                  )
                                ]
                          )
                        , ( "series", list <| List.map mapPieSeries option.series )
                        ]
