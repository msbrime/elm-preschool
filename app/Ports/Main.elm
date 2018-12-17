port module Ports.Main exposing (onQuestionsLoaded)

import Json.Encode as Encode 

port onQuestionsLoaded : (Encode.Value -> msg) -> Sub msg