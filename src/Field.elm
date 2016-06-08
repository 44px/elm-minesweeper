module Field exposing (Model, init, update, view)

import Array exposing (Array)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

import Cell


-- Model

type alias Model = Array Row

type alias Row = Array Cell.Model

type alias RowIndex = Int

type alias ColIndex = Int


init rows columns =
  Array.repeat rows (initRow columns)


initRow columns =
  Array.repeat columns (Cell.init (Cell.Safe 0))

-- TODO:
getNeighbourCells =
  []


-- Update

type Msg = Click RowIndex ColIndex Cell.Msg


update msg model =
  case msg of
    -- TODO: init here?
    Click rowIndex colIndex msg ->
      updateCell model rowIndex colIndex msg


updateCell field rowIndex colIndex msg =
  let
    row = Maybe.withDefault Array.empty (Array.get rowIndex field)
    maybeCell = Array.get colIndex row
  in
    case maybeCell of
      Just cell ->
        Array.set rowIndex (Array.set colIndex (Cell.update msg cell) row) field

      Nothing ->
        field


-- View

view model =
  div
    [class "field"]
    (List.map renderRow (Array.toIndexedList model))


renderRow (index, row) =
  div
    [class "field__row"]
    (List.map (renderCell index) (Array.toIndexedList row))


renderCell rowIndex (index, cell) =
  App.map (Click rowIndex index) (Cell.view cell)
