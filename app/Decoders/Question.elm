module Decoders.Question exposing (questionsDecoder)

import Json.Decode exposing (list, succeed, int, string, Decoder)
import Json.Decode.Pipeline as Pipeline exposing (required)
import Models.Question as Question exposing (Question)
import Models.Resource exposing (Resource,ResourceType(..))
import Decoders.Resource exposing (resourceDecoder)

questionsDecoder : Decoder (List Question)
questionsDecoder = 
    (list questionDecoder)


questionDecoder : Decoder Question
questionDecoder = 
    succeed Question
        |> required "answer" string
        |> required "explanation" string
        |> required "id" int
        |> required "options" (list string)
        |> required "question" string
        |> required "resource" resourceDecoder