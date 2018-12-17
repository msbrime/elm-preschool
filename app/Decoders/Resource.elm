module Decoders.Resource exposing (resourceDecoder)

import Json.Encode as Encode
import Json.Decode as Decode exposing (succeed, string, Decoder)
import Json.Decode.Pipeline as Pipeline exposing (required)
import Models.Resource exposing (Resource,ResourceType(..))

resourceDecoder : Decoder Resource
resourceDecoder =
        Decode.succeed Resource
            |> required "type" (succeed Image)
            |> required "url" string