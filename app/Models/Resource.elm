module Models.Resource exposing (ResourceType(..),Resource,empty)

type ResourceType = Image
    | Video

type alias Resource = 
    { kind : ResourceType
    , url : String
    }

empty = 
    Resource Image ""
