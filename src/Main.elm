import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

import Field

main =
  App.beginnerProgram
    { model = Field.init 10 20
    , update = Field.update
    , view = Field.view
  }
