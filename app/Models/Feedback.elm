module Models.Feedback exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

type FeedbackType = Correct
    | Incorrect

type alias Model =  
    { feedbackType : FeedbackType
    , score : Int
    , feedbackText : String
    }

view : Model -> msg -> (Html msg)
view model msg =
    div [class "feedback clearfix animated fadeIn" ] 
    [ p [] [ text <| narrationText model.feedbackType]
    , p [] [text model.feedbackText ] 
    , div [class "question__score text-center"] []
    , button [class "question__explanation-close circular right", onClick msg] [text "OK!"]
    ]

narrationText : FeedbackType -> String
narrationText feedbackType =
    case feedbackType of
        Correct ->
            "That's Right!"
        Incorrect ->
            "Oh no! You got this one wrong"
