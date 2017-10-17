module ECharts.Style
    exposing
        ( TitleOption
        , TooltipOption
        , TooltipAxisPointerOption
        , TooltipTrigger(..)
        , TooltipTriggerOn(..)
        , TooltipPosition(..)
        , TooltipAxisPointerType(..)
        , LegendOption
        , LegendAlignment(..)
        , XAxisOption
        , YAxisOption
        , Orientation(..)
        , HorizontalAlignment(..)
        , VerticalAlignment(..)
        , Spacing(..)
        , SelectedMode(..)
        , AnimationEasing(..)
        , LineStyleType(..)
        , LineStyleOption
        , CrossStyleOption
        , ShadowStyleOption
        , TextStyleOption
        , defaultTitleOption
        , defaultTooltipOption
        , defaultTooltipAxisPointerOption
        , defaultLegendOption
        , defaultXAxisOption
        , defaultYAxisOption
        , defaultLineStyleOption
        , defaultCrossStyleOption
        , defaultShadowStyleOption
        , defaultTextStyleOption
        , encodeTitleOption
        , encodeTooltipOption
        , encodeLegendOption
        , encodeXAxisOption
        , encodeYAxisOption
        , encodeLineStyleOption
        , encodeCrossStyleOption
        , encodeShadowStyleOption
        , encodeTextStyleOption
        , encodeOrientationValue
        , encodeHorizontalAlignmentValue
        , encodeVerticalAlignmentValue
        , encodeSpacingValue
        , encodeSelectedModeValue
        , encodeAnimationEasingValue
        , encodeLineStyleTypeValue
        )

{-| Chart layout and style related options


# Chart Title Options

@docs TitleOption

@docs defaultTitleOption

@docs encodeTitleOption


# Tooltip Options

@docs TooltipOption

@docs defaultTooltipOption

@docs encodeTooltipOption

@docs TooltipAxisPointerOption

@docs defaultTooltipAxisPointerOption


## Tooltip Attribute Values

@docs TooltipTrigger

@docs TooltipTriggerOn

@docs TooltipPosition

@docs TooltipAxisPointerType


# Legend Options

@docs LegendOption

@docs defaultLegendOption

@docs encodeLegendOption


# XAxis Options

@docs XAxisOption

@docs defaultXAxisOption

@docs encodeXAxisOption


# YAxis Options

@docs YAxisOption

@docs defaultYAxisOption

@docs encodeYAxisOption


## Legend Attribute Values

@docs LegendAlignment


# Style Options

@docs LineStyleOption

@docs defaultLineStyleOption

@docs encodeLineStyleOption

@docs CrossStyleOption

@docs defaultCrossStyleOption

@docs encodeCrossStyleOption

@docs ShadowStyleOption

@docs defaultShadowStyleOption

@docs encodeShadowStyleOption

@docs TextStyleOption

@docs defaultTextStyleOption

@docs encodeTextStyleOption


## Style Attribute Values

@docs Orientation

@docs encodeOrientationValue

@docs HorizontalAlignment

@docs encodeHorizontalAlignmentValue

@docs VerticalAlignment

@docs encodeVerticalAlignmentValue

@docs Spacing

@docs encodeSpacingValue

@docs SelectedMode

@docs encodeSelectedModeValue

@docs AnimationEasing

@docs encodeAnimationEasingValue

@docs LineStyleType

@docs encodeLineStyleTypeValue

-}

import Json.Encode exposing (Value, object, string, bool, int, float, list)
import Helpers
    exposing
        ( toValueList
        , toStringValueList
        , toFloatValueList
        , toIntValueList
        , toBoolValueList
        )


-- title


{-| describe the chart title
[option](https://ecomfe.github.io/echarts-doc/public/en/option.html#title)
-}
type alias TitleOption =
    { show : Maybe Bool
    , text : Maybe String
    , link : Maybe String
    , target : Maybe String
    , textStyle : Maybe TextStyleOption
    , textAlign : Maybe HorizontalAlignment
    , textBaseline : Maybe VerticalAlignment
    , subtext : Maybe String
    , sublink : Maybe String
    , subtarget : Maybe String
    , subtextStyle : Maybe TextStyleOption
    , padding : Maybe Spacing
    , itemGap : Maybe Float
    , zlevel : Maybe Int
    , z : Maybe Int
    , left : Maybe String
    , top : Maybe String
    , right : Maybe String
    , bottom : Maybe String
    , backgroundColor : Maybe String
    , borderColor : Maybe String
    , borderWidth : Maybe String
    , shadowBlur : Maybe Int
    , shadowColor : Maybe String
    , shadowOffsetX : Maybe Int
    , shadowOffsetY : Maybe Int
    }


{-| create a title option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultTitleOption : TitleOption
defaultTitleOption =
    { show = Nothing
    , text = Nothing
    , link = Nothing
    , target = Nothing
    , textStyle = Nothing
    , textAlign = Nothing
    , textBaseline = Nothing
    , subtext = Nothing
    , sublink = Nothing
    , subtarget = Nothing
    , subtextStyle = Nothing
    , padding = Nothing
    , itemGap = Nothing
    , zlevel = Nothing
    , z = Nothing
    , left = Nothing
    , top = Nothing
    , right = Nothing
    , bottom = Nothing
    , backgroundColor = Nothing
    , borderColor = Nothing
    , borderWidth = Nothing
    , shadowBlur = Nothing
    , shadowColor = Nothing
    , shadowOffsetX = Nothing
    , shadowOffsetY = Nothing
    }


{-| encode the title option to Json.Encode.Value
-}
encodeTitleOption : TitleOption -> Value
encodeTitleOption option =
    object <|
        List.concat
            [ toBoolValueList "show" option.show
            , toStringValueList "text" option.text
            , toStringValueList "link" option.link
            , toStringValueList "target" option.target
            , toValueList encodeTextStyleOption "textStyle" option.textStyle
            , toValueList encodeHorizontalAlignmentValue "textAlign" option.textAlign
            , toValueList encodeVerticalAlignmentValue "textBaseline" option.textBaseline
            , toStringValueList "subtext" option.subtext
            , toStringValueList "sublink" option.sublink
            , toStringValueList "subtarget" option.subtarget
            , toValueList encodeTextStyleOption "subtextStyle" option.subtextStyle
            , toValueList encodeSpacingValue "padding" option.padding
            , toFloatValueList "itemGap" option.itemGap
            , toIntValueList "zlevel" option.zlevel
            , toIntValueList "z" option.z
            , toStringValueList "left" option.left
            , toStringValueList "top" option.top
            , toStringValueList "right" option.right
            , toStringValueList "bottom" option.bottom
            , toStringValueList "backgroundColor" option.backgroundColor
            , toStringValueList "borderColor" option.borderColor
            , toStringValueList "borderWidth" option.borderWidth
            , toIntValueList "shadowBlur" option.shadowBlur
            , toStringValueList "shadowColor" option.shadowColor
            , toIntValueList "shadowOffsetX" option.shadowOffsetX
            , toIntValueList "shadowOffsetY" option.shadowOffsetY
            ]



-- tooltip


{-| describe the tooltip
[option](https://ecomfe.github.io/echarts-doc/public/en/option.html#tooltip)
-}
type alias TooltipOption =
    { show : Maybe Bool
    , showContent : Maybe Bool
    , trigger : Maybe TooltipTrigger
    , triggerOn : Maybe TooltipTriggerOn
    , alwaysShowContent : Maybe Bool
    , showDelay : Maybe Int
    , hideDelay : Maybe Int
    , enterable : Maybe Bool
    , position : Maybe TooltipPosition
    , confine : Maybe Bool
    , transitionDuration : Maybe Float
    , formatter : Maybe String
    , backgroundColor : Maybe String
    , borderColor : Maybe String
    , borderWidth : Maybe String
    , padding : Maybe Spacing
    , textStyle : Maybe TextStyleOption
    , extraCssText : Maybe String
    , axisPointer : Maybe TooltipAxisPointerOption
    , data : Maybe (List { date : String, value : Float, name : String })
    }


{-| create a tooltip option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultTooltipOption : TooltipOption
defaultTooltipOption =
    { show = Nothing
    , showContent = Nothing
    , trigger = Nothing
    , triggerOn = Nothing
    , alwaysShowContent = Nothing
    , showDelay = Nothing
    , hideDelay = Nothing
    , enterable = Nothing
    , position = Nothing
    , confine = Nothing
    , transitionDuration = Nothing
    , formatter = Nothing
    , backgroundColor = Nothing
    , borderColor = Nothing
    , borderWidth = Nothing
    , padding = Nothing
    , textStyle = Nothing
    , extraCssText = Nothing
    , axisPointer = Nothing
    , data = Nothing
    }


{-| encode the tooltip option to Json.Encode.Value
-}
encodeTooltipOption : TooltipOption -> Value
encodeTooltipOption option =
    let
        dataEncoder data =
            list <|
                List.map
                    (\d ->
                        object
                            [ ( "date", string d.date )
                            , ( "value", float d.value )
                            , ( "name", string d.name )
                            ]
                    )
                    data
    in
        object <|
            List.concat
                [ toBoolValueList "show" option.show
                , toBoolValueList "showContent" option.showContent
                , toValueList encodeTooltipTriggerValue "trigger" option.trigger
                , toValueList encodeTooltipTriggerOnValue "triggerOn" option.triggerOn
                , toBoolValueList "alwaysShowContent" option.alwaysShowContent
                , toIntValueList "showDelay" option.showDelay
                , toIntValueList "hideDelay" option.hideDelay
                , toBoolValueList "enterable" option.enterable
                , toValueList encodeTooltipPositionValue "position" option.position
                , toBoolValueList "confine" option.confine
                , toFloatValueList "transitionDuration" option.transitionDuration
                , toStringValueList "formatter" option.formatter
                , toStringValueList "backgroundColor" option.backgroundColor
                , toStringValueList "borderColor" option.borderColor
                , toStringValueList "borderWidth" option.borderWidth
                , toValueList encodeSpacingValue "padding" option.padding
                , toValueList encodeTextStyleOption "textStyle" option.textStyle
                , toStringValueList "extraCssText" option.extraCssText
                , toValueList encodeTooltipAxisPointerOption "axisPointer" option.axisPointer
                , toValueList dataEncoder "data" option.data
                ]


{-| describe the tooltip axis pointer
[option](https://ecomfe.github.io/echarts-doc/public/en/option.html#tooltip.axisPointer)
-}
type alias TooltipAxisPointerOption =
    { type_ : Maybe TooltipAxisPointerType
    , axis : Maybe String
    , animation : Maybe Bool
    , animationThreshold : Maybe Int
    , animationDuration : Maybe Int
    , animationEasing : Maybe AnimationEasing
    , animationDelay : Maybe Int
    , animationDurationUpdate : Maybe Int
    , animationEasingUpdate : Maybe AnimationEasing
    , animationDelayUpdate : Maybe Int
    , lineStyle : Maybe LineStyleOption
    , crossStyle : Maybe CrossStyleOption
    , shadowStyle : Maybe ShadowStyleOption
    }


{-| create a tooltip axis pointer option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultTooltipAxisPointerOption : TooltipAxisPointerOption
defaultTooltipAxisPointerOption =
    { type_ = Nothing
    , axis = Nothing
    , animation = Nothing
    , animationThreshold = Nothing
    , animationDuration = Nothing
    , animationEasing = Nothing
    , animationDelay = Nothing
    , animationDurationUpdate = Nothing
    , animationEasingUpdate = Nothing
    , animationDelayUpdate = Nothing
    , lineStyle = Nothing
    , crossStyle = Nothing
    , shadowStyle = Nothing
    }


encodeTooltipAxisPointerOption : TooltipAxisPointerOption -> Value
encodeTooltipAxisPointerOption option =
    object <|
        List.concat
            [ toValueList encodeTooltipAxisPointerTypeValue "type" option.type_
            , toStringValueList "axis" option.axis
            , toBoolValueList "animation" option.animation
            , toIntValueList "animationThreshold" option.animationThreshold
            , toIntValueList "animationDuration" option.animationDuration
            , toValueList encodeAnimationEasingValue "animationEasing" option.animationEasing
            , toIntValueList "animationDelay" option.animationDelay
            , toIntValueList "animationDurationUpdate" option.animationDurationUpdate
            , toValueList encodeAnimationEasingValue "animationEasingUpdate" option.animationEasingUpdate
            , toIntValueList "animationDelayUpdate" option.animationDelayUpdate
            , toValueList encodeLineStyleOption "lineStyle" option.lineStyle
            , toValueList encodeCrossStyleOption "crossStyle" option.crossStyle
            , toValueList encodeShadowStyleOption "shadowStyle" option.shadowStyle
            ]


{-| tooltip trigger
[value](https://ecomfe.github.io/echarts-doc/public/en/option.html#tooltip.trigger)
-}
type TooltipTrigger
    = TriggerByItem
    | TriggerByAxis


encodeTooltipTriggerValue : TooltipTrigger -> Value
encodeTooltipTriggerValue value =
    case value of
        TriggerByItem ->
            string "item"

        TriggerByAxis ->
            string "axis"


{-| tooltip triggerOn
[value](https://ecomfe.github.io/echarts-doc/public/en/option.html#tooltip.triggerOn)
-}
type TooltipTriggerOn
    = MouseMoveTriggerTooltip
    | ClickTriggerTooltip
    | NoneTriggerTooltip


encodeTooltipTriggerOnValue : TooltipTriggerOn -> Value
encodeTooltipTriggerOnValue value =
    case value of
        MouseMoveTriggerTooltip ->
            string "mousemove"

        ClickTriggerTooltip ->
            string "click"

        NoneTriggerTooltip ->
            string "none"


{-| tooltip position
[value](https://ecomfe.github.io/echarts-doc/public/en/option.html#tooltip.position)
-}
type TooltipPosition
    = AbsoluteTooltipPosiotion Int Int
    | RelativeTooltipPosition String String


encodeTooltipPositionValue : TooltipPosition -> Value
encodeTooltipPositionValue value =
    case value of
        AbsoluteTooltipPosiotion a b ->
            list [ int a, int b ]

        RelativeTooltipPosition a b ->
            list [ string a, string b ]


{-| tooltip axis pointer type
[value](https://ecomfe.github.io/echarts-doc/public/en/option.html#tooltip.axisPointer.type)
-}
type TooltipAxisPointerType
    = LineTooltipAxisPointer
    | CrossTooltipAxisPointer
    | ShadowTooltipAxisPointer


encodeTooltipAxisPointerTypeValue : TooltipAxisPointerType -> Value
encodeTooltipAxisPointerTypeValue value =
    case value of
        LineTooltipAxisPointer ->
            string "line"

        CrossTooltipAxisPointer ->
            string "cross"

        ShadowTooltipAxisPointer ->
            string "shadow"



-- legend


{-| describe the legend
[option](https://ecomfe.github.io/echarts-doc/public/en/option.html#legend)
-}
type alias LegendOption =
    { show : Maybe Bool
    , zlevel : Maybe Int
    , z : Maybe Int
    , left : Maybe String
    , top : Maybe String
    , right : Maybe String
    , bottom : Maybe String
    , width : Maybe String
    , height : Maybe String
    , orient : Maybe Orientation
    , align : Maybe LegendAlignment
    , padding : Maybe Spacing
    , itemGap : Maybe Int
    , itemWidth : Maybe Int
    , itemHeight : Maybe Int
    , formatter : Maybe String
    , selectedMode : Maybe SelectedMode
    , inactiveColor : Maybe String
    , selected : Maybe (List ( String, Bool ))
    , textStyle : Maybe TextStyleOption
    , tooltip : Maybe TooltipOption
    , data :
        Maybe
            (List
                { name : String
                , icon : String
                , textStyle : TextStyleOption
                }
            )
    , backgroundColor : Maybe String
    , borderColor : Maybe String
    , borderWidth : Maybe Int
    , shadowBlur : Maybe Int
    , shadowColor : Maybe String
    , shadowOffsetX : Maybe Int
    , shadowOffsetY : Maybe Int
    }


{-| create a legend option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultLegendOption : LegendOption
defaultLegendOption =
    { show = Nothing
    , zlevel = Nothing
    , z = Nothing
    , left = Nothing
    , top = Nothing
    , right = Nothing
    , bottom = Nothing
    , width = Nothing
    , height = Nothing
    , orient = Nothing
    , align = Nothing
    , padding = Nothing
    , itemGap = Nothing
    , itemWidth = Nothing
    , itemHeight = Nothing
    , formatter = Nothing
    , selectedMode = Nothing
    , inactiveColor = Nothing
    , selected = Nothing
    , textStyle = Nothing
    , tooltip = Nothing
    , data = Nothing
    , backgroundColor = Nothing
    , borderColor = Nothing
    , borderWidth = Nothing
    , shadowBlur = Nothing
    , shadowColor = Nothing
    , shadowOffsetX = Nothing
    , shadowOffsetY = Nothing
    }


{-| encode the legend option to Json.Encode.Value
-}
encodeLegendOption : LegendOption -> Value
encodeLegendOption option =
    let
        selectedEncoder selected =
            object <|
                List.map
                    (\d -> ( Tuple.first d, bool <| Tuple.second d ))
                    selected

        dataEncoder data =
            list <|
                List.map
                    (\d ->
                        object
                            [ ( "name", string d.name )
                            , ( "icon", string d.icon )
                            , ( "textStyle", encodeTextStyleOption d.textStyle )
                            ]
                    )
                    data
    in
        object <|
            List.concat
                [ toBoolValueList "show" option.show
                , toIntValueList "zlevel" option.zlevel
                , toIntValueList "z" option.z
                , toStringValueList "left" option.left
                , toStringValueList "top" option.top
                , toStringValueList "right" option.right
                , toStringValueList "bottom" option.bottom
                , toStringValueList "width" option.width
                , toStringValueList "height" option.height
                , toValueList encodeOrientationValue "orient" option.orient
                , toValueList encodeLegendAlignmentValue "align" option.align
                , toValueList encodeSpacingValue "padding" option.padding
                , toIntValueList "itemGap" option.itemGap
                , toIntValueList "itemWidth" option.itemWidth
                , toStringValueList "formatter" option.formatter
                , toValueList encodeSelectedModeValue "selectedMode" option.selectedMode
                , toStringValueList "inactiveColor" option.inactiveColor
                , toValueList selectedEncoder "selected" option.selected
                , toValueList encodeTextStyleOption "textStyle" option.textStyle
                , toValueList encodeTooltipOption "tooltip" option.tooltip
                , toValueList dataEncoder "data" option.data
                , toStringValueList "backgroundColor" option.backgroundColor
                , toStringValueList "borderColor" option.borderColor
                , toIntValueList "borderWidth" option.borderWidth
                , toIntValueList "shadowBlur" option.shadowBlur
                , toStringValueList "shadowColor" option.shadowColor
                , toIntValueList "shadowOffsetX" option.shadowOffsetX
                , toIntValueList "shadowOffsetY" option.shadowOffsetY
                ]


{-| legend alignment
[value](https://ecomfe.github.io/echarts-doc/public/en/option.html#legend.align)
-}
type LegendAlignment
    = AutoLegendAlignment
    | LeftLegendAlignment
    | RightLegendAlignment


encodeLegendAlignmentValue : LegendAlignment -> Value
encodeLegendAlignmentValue value =
    case value of
        AutoLegendAlignment ->
            string "auto"

        LeftLegendAlignment ->
            string "left"

        RightLegendAlignment ->
            string "right"



-- xAxis


{-| describe the xAxis
[option](https://ecomfe.github.io/echarts-doc/public/en/option.html#xAxis)
-}
type alias XAxisOption =
    { show : Maybe Bool
    , type_ : Maybe String
    , data :
        Maybe
            (List
                { value : String
                , textStyle : TextStyleOption
                }
            )
    }


{-| create a xAxis option of for default value

This function creates an All-Nothing XAxisOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultXAxisOption : XAxisOption
defaultXAxisOption =
    { show = Nothing
    , type_ = Nothing
    , data = Nothing
    }


{-| encode the xAxis option to Json.Encode.Value
-}
encodeXAxisOption : XAxisOption -> Value
encodeXAxisOption option =
    let
        dataEncoder data =
            list <|
                List.map
                    (\d ->
                        object
                            [ ( "value", string d.value )
                            , ( "textStyle", encodeTextStyleOption d.textStyle )
                            ]
                    )
                    data
    in
        object <|
            List.concat
                [ toBoolValueList "show" option.show
                , toValueList dataEncoder "data" option.data
                , toStringValueList "type" option.type_
                ]



-- yAxis


{-| describe the yAxis
[option](https://ecomfe.github.io/echarts-doc/public/en/option.html#yAxis)
-}
type alias YAxisOption =
    { show : Maybe Bool
    , type_ : Maybe String
    , data :
        Maybe
            (List
                { value : String
                , textStyle : TextStyleOption
                }
            )
    }


{-| create a yAxis option of for default value

This function creates an All-Nothing YAxisOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultYAxisOption : YAxisOption
defaultYAxisOption =
    { show = Nothing
    , type_ = Nothing
    , data = Nothing
    }


{-| encode the yAxis option to Json.Encode.Value
-}
encodeYAxisOption : YAxisOption -> Value
encodeYAxisOption option =
    let
        dataEncoder data =
            list <|
                List.map
                    (\d ->
                        object
                            [ ( "value", string d.value )
                            , ( "textStyle", encodeTextStyleOption d.textStyle )
                            ]
                    )
                    data
    in
        object <|
            List.concat
                [ toBoolValueList "show" option.show
                , toValueList dataEncoder "data" option.data
                , toStringValueList "type" option.type_
                ]



-- style options


{-| describe the line style option
-}
type alias LineStyleOption =
    { color : Maybe String
    , width : Maybe Int
    , type_ : Maybe LineStyleType
    , shadowBlur : Maybe Int
    , shadowColor : Maybe String
    , shadowOffsetX : Maybe Int
    , shadowOffsetY : Maybe Int
    , opacity : Maybe Float
    }


{-| create a line style option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultLineStyleOption : LineStyleOption
defaultLineStyleOption =
    { color = Nothing
    , width = Nothing
    , type_ = Nothing
    , shadowBlur = Nothing
    , shadowColor = Nothing
    , shadowOffsetX = Nothing
    , shadowOffsetY = Nothing
    , opacity = Nothing
    }


{-| encode the line style option to Json.Encode.Value
-}
encodeLineStyleOption : LineStyleOption -> Value
encodeLineStyleOption option =
    object <|
        List.concat
            [ toStringValueList "color" option.color
            , toIntValueList "width" option.width
            , toValueList encodeLineStyleTypeValue "type" option.type_
            , toIntValueList "shadowBlur" option.shadowBlur
            , toStringValueList "shadowColor" option.shadowColor
            , toIntValueList "shadowOffsetX" option.shadowOffsetX
            , toIntValueList "shadowOffsetY" option.shadowOffsetY
            , toFloatValueList "opacity" option.opacity
            ]


{-| describe the cross style option
-}
type alias CrossStyleOption =
    { color : Maybe String
    , width : Maybe Int
    , type_ : Maybe LineStyleType
    , shadowBlur : Maybe Int
    , shadowColor : Maybe String
    , shadowOffsetX : Maybe Int
    , shadowOffsetY : Maybe Int
    , opacity : Maybe Float
    , textStyle : Maybe TextStyleOption
    }


{-| create a cross style option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultCrossStyleOption : CrossStyleOption
defaultCrossStyleOption =
    { color = Nothing
    , width = Nothing
    , type_ = Nothing
    , shadowBlur = Nothing
    , shadowColor = Nothing
    , shadowOffsetX = Nothing
    , shadowOffsetY = Nothing
    , opacity = Nothing
    , textStyle = Nothing
    }


{-| encode the cross style option to Json.Encode.Value
-}
encodeCrossStyleOption : CrossStyleOption -> Value
encodeCrossStyleOption option =
    object <|
        List.concat
            [ toStringValueList "color" option.color
            , toIntValueList "width" option.width
            , toValueList encodeLineStyleTypeValue "type" option.type_
            , toIntValueList "shadowBlur" option.shadowBlur
            , toStringValueList "shadowColor" option.shadowColor
            , toIntValueList "shadowOffsetX" option.shadowOffsetX
            , toIntValueList "shadowOffsetY" option.shadowOffsetY
            , toFloatValueList "opacity" option.opacity
            , toValueList encodeTextStyleOption "shadowOffsetY" option.textStyle
            ]


{-| describe the shadow style option
-}
type alias ShadowStyleOption =
    { color : Maybe String
    , shadowBlur : Maybe Int
    , shadowColor : Maybe String
    , shadowOffsetX : Maybe Int
    , shadowOffsetY : Maybe Int
    , opacity : Maybe Float
    }


{-| create a shadow style option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultShadowStyleOption : ShadowStyleOption
defaultShadowStyleOption =
    { color = Nothing
    , shadowBlur = Nothing
    , shadowColor = Nothing
    , shadowOffsetX = Nothing
    , shadowOffsetY = Nothing
    , opacity = Nothing
    }


{-| encode the shadow option to Json.Encode.Value
-}
encodeShadowStyleOption : ShadowStyleOption -> Value
encodeShadowStyleOption option =
    object <|
        List.concat
            [ toStringValueList "color" option.color
            , toIntValueList "shadowBlur" option.shadowBlur
            , toStringValueList "shadowColor" option.shadowColor
            , toIntValueList "shadowOffsetX" option.shadowOffsetX
            , toIntValueList "shadowOffsetY" option.shadowOffsetY
            , toFloatValueList "opacity" option.opacity
            ]


{-| describe the rich option
-}
type alias RichOption =
    {}


{-| create a rich option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultRichOption : RichOption
defaultRichOption =
    {}


{-| encode the text style option to Json.Encode.Value
-}
encodeRichOption : RichOption -> Value
encodeRichOption option =
    object <|
        List.concat
            []


{-| describe the text style option
-}
type alias TextStyleOption =
    { color : Maybe String
    , fontStyle : Maybe String
    , fontWeight : Maybe String
    , fontFamily : Maybe String
    , fontSize : Maybe Float
    , lineHeight : Maybe Float
    , rich : Maybe RichOption
    }


{-| create a text style option of for default value

This function creates an All-Nothing TitleOption.
[ECharts](https://ecomfe.github.io/echarts-doc/public/en/option.html)
applies the default value when the option attribute is not specified.

-}
defaultTextStyleOption : TextStyleOption
defaultTextStyleOption =
    { color = Nothing
    , fontStyle = Nothing
    , fontWeight = Nothing
    , fontFamily = Nothing
    , fontSize = Nothing
    , lineHeight = Nothing
    , rich = Nothing
    }


{-| encode the text style option to Json.Encode.Value
-}
encodeTextStyleOption : TextStyleOption -> Value
encodeTextStyleOption option =
    object <|
        List.concat
            [ toStringValueList "color" option.color
            , toStringValueList "fontStyle" option.fontStyle
            , toStringValueList "fontWeight" option.fontWeight
            , toStringValueList "fontFamily" option.fontFamily
            , toFloatValueList "fontSize" option.fontSize
            , toFloatValueList "lineHeight" option.lineHeight
            , toValueList encodeRichOption "rich" option.rich
            ]


{-| describe the orientation attribute
-}
type Orientation
    = Horizontal
    | Vertical


{-| encode the orientation value to Json.Encode.Value
-}
encodeOrientationValue : Orientation -> Value
encodeOrientationValue value =
    case value of
        Horizontal ->
            string "horizontal"

        Vertical ->
            string "vertical"


{-| describe horizontal alignment: left, center, right
-}
type HorizontalAlignment
    = Left
    | Center
    | Right


{-| encode the horizontal alignment value to Json.Encode.Value
-}
encodeHorizontalAlignmentValue : HorizontalAlignment -> Value
encodeHorizontalAlignmentValue value =
    case value of
        Left ->
            string "left"

        Center ->
            string "center"

        Right ->
            string "right"


{-| describe vertical alignment: top, middle, bottom
-}
type VerticalAlignment
    = Top
    | Middle
    | Bottom


{-| encode the vertical alignment value to Json.Encode.Value
-}
encodeVerticalAlignmentValue : VerticalAlignment -> Value
encodeVerticalAlignmentValue value =
    case value of
        Top ->
            string "top"

        Middle ->
            string "middle"

        Bottom ->
            string "bottom"


{-| describe spacing setting
-}
type Spacing
    = Spacing Float
    | VHSpacing Float Float
    | FineSpacing Float Float Float Float


{-| encode the spacing value to Json.Encode.Value
-}
encodeSpacingValue : Spacing -> Value
encodeSpacingValue spacing =
    case spacing of
        Spacing val ->
            float val

        VHSpacing a b ->
            list [ float a, float b ]

        FineSpacing a b c d ->
            list [ float a, float b, float c, float d ]


{-| describe the item selected mode
-}
type SelectedMode
    = TrueSelectedMode
    | FalseSelectedMode
    | SingleSelectedMode
    | MultipleSelectedMode


{-| encode the selected mode value to Json.Encode.Value
-}
encodeSelectedModeValue : SelectedMode -> Value
encodeSelectedModeValue value =
    case value of
        TrueSelectedMode ->
            bool True

        FalseSelectedMode ->
            bool False

        SingleSelectedMode ->
            string "single"

        MultipleSelectedMode ->
            string "multiple"


{-| describe the animation easing
-}
type AnimationEasing
    = CubicOutAnimationEasing


{-| encode the animation easing value to Json.Encode.Value
-}
encodeAnimationEasingValue : AnimationEasing -> Value
encodeAnimationEasingValue value =
    case value of
        CubicOutAnimationEasing ->
            string "cubicOut"


{-| describe the line style type
-}
type LineStyleType
    = SolidLine
    | DashedLine
    | DottedLine


{-| encode the line style type value to Json.Encode.Value
-}
encodeLineStyleTypeValue : LineStyleType -> Value
encodeLineStyleTypeValue value =
    case value of
        SolidLine ->
            string "solid"

        DashedLine ->
            string "dashed"

        DottedLine ->
            string "dotted"
