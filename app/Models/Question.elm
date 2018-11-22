module Models.Question exposing (Question)

import Models.Resource exposing (Resource)

type alias Question = 
    { answer: String
    , explanation: String
    , id: Int
    , options: List String
    , question: String
    , resource : Resource
    }