import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

import Field

main =
  App.beginnerProgram
    { model = Field.init 20 10
    , update = Field.update
    , view = Field.view
  }
