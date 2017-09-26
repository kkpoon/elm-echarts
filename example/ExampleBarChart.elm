module Example exposing (..)

import Html exposing (Html, node)
import Html.Attributes exposing (attribute, style)
import ECharts exposing (ChartType(..), toJsonString)
import ECharts.BarChart exposing (defaultBarChartOption, defaultBarSeriesOption)
import ECharts.Style
    exposing
        ( defaultTitleOption
        , defaultTooltipOption
        , defaultLegendOption
        , defaultXAxisOption
        , defaultYAxisOption
        , defaultTextStyleOption
        )


bar : Html msg
bar =
    let
        title =
            { defaultTitleOption
                | text = Just "Bar chart title"
                , left = Just "center"
            }

        tooltip =
            { defaultTooltipOption
                | trigger = Just "axis"
            }

        legend =
            { defaultLegendOption
                | top = Just "bottom"
                , left = Just "center"
                , data =
                    Just <|
                        List.map
                            (\name ->
                                { name = name
                                , textStyle = defaultTextStyleOption
                                }
                            )
                            [ "A", "B", "C" ]
            }

        xAxis =
            { defaultXAxisOption
                | data = Just [ "X", "Y", "Z" ]
                , type_ = Just "category"
            }

        yAxis =
            { defaultYAxisOption
                | type_ = Just "value"
            }

        series =
            [ { defaultBarSeriesOption
                | name = Just "A"
                , barGap = Just 0
                , data =
                    Just
                        [ { value = 335 }
                        , { value = 310 }
                        , { value = 234 }
                        ]
              }
            , { defaultBarSeriesOption
                | name = Just "B"
                , data =
                    Just
                        [ { value = 235 }
                        , { value = 210 }
                        , { value = 134 }
                        ]
              }
            , { defaultBarSeriesOption
                | name = Just "C"
                , data =
                    Just
                        [ { value = 336 }
                        , { value = 311 }
                        , { value = 235 }
                        ]
              }
            ]

        BarChart =
            BarChart
                ({ defaultBarChartOption
                    | title = Just title
                    , tooltip = Just tooltip
                    , legend = Just legend
                    , xAxis = Just xAxis
                    , yAxis = Just yAxis
                    , series = Just series
                 }
                )

        chartOption =
            toJsonString BarChart
    in
        node "echarts-webcomponent"
            [ style [ ( "width", "400px" ), ( "height", "300px" ) ]
            , attribute "option" chartOption
            ]
            []
