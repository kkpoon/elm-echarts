module ECharts
    exposing
        ( Orientation
        , PieSeries
        , PieChartOption
        , ChartType
        , toJsonString
        )

{-| This is a [EChart](http://echarts.baidu.com/) chart option types
collection and a helper to use
[EChart WebComponent](https://github.com/kkpoon/echarts-webcomponent).

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

import Json.Encode exposing (encode, object, string, bool, int, float, list)


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
        Maybe
            { show : Bool
            , text : String
            , subtext : String
            , left : String
            }
    , tooltip :
        Maybe
            { show : Bool
            , formatter : String
            }
    , legend :
        Maybe
            { show : Bool
            , orient : Orientation
            , left : String
            , data : List String
            }
    , series : List PieSeries
    }


{-| the chart type
-}
type ChartType
    = PieChart PieChartOption


{-| convert the chart option to a string of json, which could apply to the
[echart-webcomponent] (https://github.com/kkpoon/echarts-webcomponent) `option`
attribute
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
                        ((case option.title of
                            Just title ->
                                [ ( "title"
                                  , object
                                        [ ( "show", bool title.show )
                                        , ( "text", string title.text )
                                        , ( "subtext", string title.subtext )
                                        , ( "left", string title.left )
                                        ]
                                  )
                                ]

                            Nothing ->
                                []
                         )
                            |> List.append
                                (case option.tooltip of
                                    Just tooltip ->
                                        [ ( "tooltip"
                                          , object
                                                [ ( "show", bool tooltip.show )
                                                , ( "trigger", string "item" )
                                                , ( "formatter", string tooltip.formatter )
                                                ]
                                          )
                                        ]

                                    Nothing ->
                                        []
                                )
                            |> List.append
                                (case option.legend of
                                    Just legend ->
                                        [ ( "legend"
                                          , object
                                                [ ( "show", bool legend.show )
                                                , ( "orient"
                                                  , string
                                                        (case legend.orient of
                                                            Horizontal ->
                                                                "horizontal"

                                                            Vertical ->
                                                                "vertical"
                                                        )
                                                  )
                                                , ( "left", string legend.left )
                                                , ( "data"
                                                  , list <|
                                                        List.map string legend.data
                                                  )
                                                ]
                                          )
                                        ]

                                    Nothing ->
                                        []
                                )
                            |> List.append
                                [ ( "series", list <| List.map mapPieSeries option.series )
                                ]
                        )
