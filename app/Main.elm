module Main exposing (Model, Msg, update, view, subscriptions, init)

import Browser
import Debug
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Models.Question exposing (Question)
import Models.Resource exposing (Resource,ResourceType(..))

main =
    Browser.sandbox
        { init = modelInitValue
        , view = view
        , update = update
    }


type alias Model =
    { questions : List Question
    , answered : List Int
    , current : Int
    }


type Msg
    = Msg1
    | Msg2


modelInitValue : Model
modelInitValue = 
    { questions = initialQuestions
    , current = 1
    , answered = [] 
    }


initialQuestions : List Question
initialQuestions = [
    {
        answer="apple"
        ,explanation="This is a red apple"
        ,id=1
        ,options=[ "apple", "peach", "pear", "orange" ]
        ,question="What's the name of this fruit?"
        ,resource={
        kind= Image
        ,url="https://images.vexels.com/media/users/3/143051/isolated/preview/7c640e541176de78cabefc799ad3efac-apple-color-stroke-icon-by-vexels.png"
        }
    },{
        answer="square"
        ,explanation="A square is a shape with four sides of equal length"
        ,id=2
        ,options=[ "square", "triangle", "circle", "rectangle" ]
        ,question="What shape is this?"
        ,resource={ 
            kind=Image
            , url="https://www.colorcombos.com/images/colors/AA0114.png"
            }
        }, {
        answer="number"
        ,explanation="This is the number 3"
        ,id=3
        ,options=[ "letter", "number" ]
        ,question="Is this a letter or number?"
        ,resource={
        kind=Image
        ,url="http://pngimg.com/uploads/number3/number3_PNG14978.png"
        }
    }, {
        answer="26"
        ,explanation="There are 26 letters in the english alphabet"
        ,id=4
        ,options=[ "10", "12", "18", "26" ]
        ,question="How many letters are in the alphabet?"
        ,resource={
        kind=Image
        ,url="https://img00.deviantart.net/4ea2/i/2015/185/b/5/vintage_floral_alphabet_png_by_chaseandlinda-d8zwtsr.png"
        }
    },{
        answer="triangle"
        ,explanation="A triangle is a shape that has 3 sides"
        ,id=5
        ,options=[ "square", "triangle", "rectangle", "circle" ]
        ,question="What Shape is this?"
        ,resource={
        kind=Image
        ,url="http://www.pngmart.com/files/4/Triangle-PNG-Photo.png"
        }
    },{
        answer="eight"
        ,explanation="This is the number eight"
        ,id=6
        ,options=[ "six", "two", "eight", "nine" ]
        ,question="What is this number called?"
        ,resource={
        kind=Image
        ,url="https://nationaldoughnutday.files.wordpress.com/2015/06/donut-number-8.png"
        }
    },{
        answer="chair"
        ,explanation="Chairs are meant for sitting"
        ,id=7
        ,options=[ "table", "bucket", "chair", "sofa" ]
        ,question="What is in the picture?"
        ,resource={
        kind=Image
        ,url="http://vignette1.wikia.nocookie.net/inanimateinsanity/images/7/76/Chair.png/revision/latest?cb=20120116174053"
        }
    }]

update : Msg -> Model -> Model
update msg model =
    case msg of
        Msg1 ->
            let
                current = model.current + 1
                answered = model.current :: model.answered
            in
                { model | current=current, answered=answered}
        Msg2 ->
            model 
            


view : Model -> Html Msg
view model =
    let
        selectedList =
            List.head <|
            List.filter (\x -> not (List.member x.id model.answered)) model.questions
        selected =
            case selectedList of
                Nothing ->
                    { answer="eight"
                    ,explanation="This is the number eight"
                    ,id=6
                    ,options=[ "six", "two", "eight", "nine" ]
                    ,question="What is this number called?"
                    ,resource={
                        kind=Image
                        ,url="https://nationaldoughnutday.files.wordpress.com/2015/06/donut-number-8.png"
                        }
                    }

                Just a ->
                    a                   
    in
        div [ class "question-set"] 
        [ 
            button [ onClick Msg1 ]
            [ text "click me" ]
            ,
            p [] [text selected.question]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init = 
    { init=modelInitValue
    , view=view
    , update=update   
    }
