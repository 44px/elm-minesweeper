module Cell exposing (Model, Kind (Mine, Safe), Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- Model

type Kind = Mine | Safe Int


type alias Model =
  { opened : Bool
  , kind : Kind
  }


init kind =
  { opened = False
  , kind = kind
  }


-- Update

type Msg = Open


update msg model =
  case msg of
    Open ->
      { model | opened = True }


-- View

view model =
  let
    classMod = if model.opened then "cell--opened" else "cell--closed"
    content = if model.opened then renderContent model.kind else ""
  in
    div
      [ class ("cell " ++ classMod)
      , onClick Open
      ]
      [ text content ]


renderContent kind =
  case kind of
    Mine ->
      "x"

    Safe n ->
      toString n
