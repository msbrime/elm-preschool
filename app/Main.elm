module Main exposing (Model, Msg, update, view, subscriptions, init)

import Browser
import Debug
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Models.Question as Question exposing (Question)
import Models.Resource exposing (Resource,ResourceType(..))
import Ports.Main exposing (onQuestionsLoaded)
import Json.Encode as Encode
import Json.Decode as Decode exposing (int, string, float, nullable, Decoder)
import Json.Decode.Pipeline as Pipeline exposing (required, optional, hardcoded)

main =
    Browser.element
        { init = modelInitValue
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


type alias Model =
    { questions : List Question
    , answered : List Int
    , current : Question
    , attempts : Int
    , score : Int
    , maxScore : Int
    , displayAnswer : Bool
    }


type Msg
    = Attempt String
    | NextQuestion
    | LoadQuestions Encode.Value


modelInitValue : String -> (Model, Cmd msg)
modelInitValue  flags = 
    ({ questions = []
    , current = Question.empty
    , answered = []
    , score = 0
    , attempts = 0
    , maxScore = 0
    , displayAnswer = False
    }, Cmd.none)

initializeModelWithQuestions : (List Question) -> Model
initializeModelWithQuestions initialQuestions = 
    { questions = initialQuestions
    , current = selectQuestion initialQuestions []
    , answered = []
    , score = 0
    , attempts = 0
    , maxScore = List.sum <| List.map (\x -> (List.length x.options) - 1) initialQuestions
    , displayAnswer = False
    }


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
    case msg of
        Attempt answer ->
            let
                correct = answer == model.current.answer
                answered = model.current.id :: model.answered
                _ = Debug.log "attempt" answer
            in
                case correct of
                    True ->
                        update NextQuestion {model|answered=answered}
                    False ->
                        ({model | attempts=(model.attempts+1)}, Cmd.none)
        NextQuestion ->
            ({ model | attempts=0, current=selectQuestion model.questions model.answered }, Cmd.none)
        LoadQuestions  questions -> 
            let
                newModel = initializeModelWithQuestions <| parseQuestions questions
            in
                (newModel, Cmd.none)


selectQuestion : List Question -> List Int -> Question
selectQuestion questionList exclude =
    let
        selectedList =
            List.head <|
            List.filter (\x -> not (List.member x.id exclude)) questionList
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
        selected
    
    
view : Model -> Html Msg
view model =
    if (List.length model.questions) > 0 then        
        div [ class "question-set"] 
        [ Question.view model.current Attempt ]
    else
        p [] [text "Loading"]


subscriptions : Model -> Sub Msg
subscriptions model =
    onQuestionsLoaded LoadQuestions


init = 
    { init=modelInitValue
    , view=view
    , update=update   
    }


parseQuestions : Encode.Value -> List Question
parseQuestions encodedQuestions = 
    let 
        result = Decode.decodeValue questionsDecoder encodedQuestions
        questions = 
            case result of 
                Ok decodedQuestions ->
                    decodedQuestions
                Err e->
                    []
    in 
        questions


questionsDecoder : Decoder (List Question)
questionsDecoder = 
    (Decode.list questionDecoder)


questionDecoder : Decoder Question
questionDecoder = 
    Decode.succeed Question
        |> required "answer" string
        |> required "explanation" string
        |> required "id" int
        |> required "options" (Decode.list string)
        |> required "question" string
        |> required "resource" resourceDecoder


resourceDecoder : Decoder Resource
resourceDecoder =
        Decode.succeed Resource
            |> required "type" (Decode.succeed Image)
            |> required "url" string