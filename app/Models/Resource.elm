module Models.Resource exposing (ResourceType(..),Resource)

type ResourceType = Image
    | Video

type alias Resource = 
    { kind : ResourceType
    , url : String
    }
