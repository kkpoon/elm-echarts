module Example exposing (..)

import Html exposing (Html, node)
import Html.Attributes exposing (attribute, style)
import ECharts exposing (ChartType(..), toJsonString)
import ECharts.PieChart exposing (defaultPieChartOption, defaultPieSeriesOption)
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


pie : Html msg
pie =
    let
        title =
            { defaultTitleOption
                | text = Just "Website Traffic Sources"
                , subtext = Just "Demo Data"
                , left = Just "center"
                , subtextStyle =
                    Just
                        { defaultTextStyleOption
                            | color = Just "red"
                            , lineHeight = Just 100
                            , rich = Just {}
                        }
            }

        tooltip =
            { defaultTooltipOption
                | formatter = Just "{a} <br/>{b} : {c} ({d}%)"
            }

        legend =
            { defaultLegendOption
                | orient = Just ECharts.Style.Vertical
                , left = Just "left"
                , data =
                    Just <|
                        List.map
                            (\name ->
                                { name = name
                                , icon = ""
                                , textStyle = defaultTextStyleOption
                                }
                            )
                            [ "Direct", "EDM", "WebAds", "VideoAds", "Search Engine" ]
            }

        series =
            { defaultPieSeriesOption
                | radius = Just ( "0", "55%" )
                , center = Just ( "50%", "60%" )
                , data =
                    Just
                        [ { value = 335, name = "Direct" }
                        , { value = 310, name = "EDM" }
                        , { value = 234, name = "WebAds" }
                        , { value = 135, name = "VideoAds" }
                        , { value = 1548, name = "Search Engine" }
                        ]
                , itemStyle =
                    Just
                        { emphasis =
                            Just
                                { shadowBlur = Just 10
                                , shadowOffsetX = Just 0
                                , shadowColor = Just "rgba(0, 0, 0, 0.5)"
                                }
                        }
            }

        pieChart =
            PieChart
                ({ defaultPieChartOption
                    | title = Just title
                    , tooltip = Just tooltip
                    , legend = Just legend
                    , series = Just [ series ]
                 }
                )

        chartOption =
            toJsonString pieChart
    in
        node "echarts-webcomponent"
            [ style [ ( "width", "600px" ), ( "height", "400px" ) ]
            , attribute "option" chartOption
            ]
            []


bar : Html msg
bar =
    let
        color =
            [ "#4A593D", "#9B90C2", "#E9CD4C" ]

        title =
            { defaultTitleOption
                | text = Just "Bar chart title"
                , left = Just "center"
            }

        tooltip =
            { defaultTooltipOption
                | trigger = Just ECharts.Style.TriggerByAxis
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
                                , icon = ""
                                , textStyle = defaultTextStyleOption
                                }
                            )
                            [ "A", "B", "C" ]
            }

        xAxis =
            { defaultXAxisOption
                | data =
                    Just <|
                        List.map
                            (\name ->
                                { value = name
                                , textStyle = defaultTextStyleOption
                                }
                            )
                            [ "X", "Y", "Z" ]
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
                        [ { value = 335, itemStyle = Just { normal = { color = Just "#DB4D6D" } } }
                        , { value = 310, itemStyle = Nothing }
                        , { value = 234, itemStyle = Nothing }
                        ]
              }
            , { defaultBarSeriesOption
                | name = Just "B"
                , data =
                    Just
                        [ { value = 235, itemStyle = Nothing }
                        , { value = 210, itemStyle = Nothing }
                        , { value = 134, itemStyle = Nothing }
                        ]
              }
            , { defaultBarSeriesOption
                | name = Just "C"
                , data =
                    Just
                        [ { value = 336, itemStyle = Nothing }
                        , { value = 311, itemStyle = Nothing }
                        , { value = 235, itemStyle = Nothing }
                        ]
              }
            ]

        barChart =
            BarChart
                ({ defaultBarChartOption
                    | title = Just title
                    , color = Just color
                    , tooltip = Just tooltip
                    , legend = Just legend
                    , xAxis = Just xAxis
                    , yAxis = Just yAxis
                    , series = Just series
                 }
                )

        chartOption =
            toJsonString barChart
    in
        node "echarts-webcomponent"
            [ style [ ( "width", "400px" ), ( "height", "300px" ) ]
            , attribute "option" chartOption
            ]
            []
