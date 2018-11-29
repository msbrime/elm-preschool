module Models.Question exposing (Question,view)

import Models.Resource exposing (Resource)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class,src)

type alias Question = 
    { answer: String
    , explanation: String
    , id: Int
    , options: List String
    , question: String
    , resource : Resource
    }

view : Question -> (String -> msg) -> Html msg
view question answerClickMsg  = 
    div [class "question"]
    [ p [class "question__heading"] [
            text question.question
        ] 
    , div [class "question__image-holder"] [
           img [class "question__image", src question.resource.url] [] 
        ]
    , ul [class "question__option-list no-bullet clearfix"] (List.map (\x -> optionView x answerClickMsg) question.options)
    ]

optionView : String -> (String -> msg) -> Html msg
optionView optionValue clickMsg = 
    li [class "question__option-item", onClick (clickMsg optionValue)] [text optionValue]