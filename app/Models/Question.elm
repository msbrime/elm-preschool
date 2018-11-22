module Models.Question exposing (Question,view)

import Models.Resource exposing (Resource)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)

type alias Question = 
    { answer: String
    , explanation: String
    , id: Int
    , options: List String
    , question: String
    , resource : Resource
    }

view : Question -> msg -> Html msg
view question answerClickMsg  = 
    div [class "question"]
    [ p [class "question__heading"] [
            text question.question
        ] 
    , div [class "question__image-holder"] [
           img [class "question__image"] [] 
        ]
    , ul [class "question__option-list no-bullet clearfix"] (List.map (\x -> optionView x answerClickMsg) question.options)
    ]

optionView : String -> msg -> Html msg
optionView optionValue clickMsg = 
    li [class "question__option-item", onClick clickMsg] [text optionValue]