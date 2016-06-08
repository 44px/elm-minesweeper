module Field exposing (Model, init, update, view)

import Array

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

import Cell


-- Model

type alias Model = List Row

type alias Row =
  { index : RowIndex
  , model : List IndexedCell
  }

type alias IndexedCell =
  { index : CellIndex
  , model : Cell.Model
  }

type alias RowIndex = Int

type alias CellIndex = Int


init width height =
  List.map (\index -> Row index (initRow width)) [0..height-1]


initRow width =
  List.map (\index -> IndexedCell index (Cell.init (Cell.Safe 0))) [0..width-1]

-- TODO: move to Array (Array Cell) structure
getCell field rowIndex cellIndex =
  (Array.get rowIndex field) `Maybe.andThen` (Array.get cellIndex)


getNeighbourCells =
  []


-- Update

type Msg = Click RowIndex CellIndex Cell.Msg


update msg model =
  case msg of
    -- TODO: init here?
    Click rowIndex cellIndex msg ->
      List.map (\row ->
        if rowIndex == row.index then
          Row row.index (List.map (\cell ->
            if cellIndex == cell.index then
              IndexedCell cell.index (Cell.update msg cell.model)
            else
              cell)
            row.model)
        else
          row
      ) model


-- View

view model =
  div
    [class "field"]
    (List.map renderRow model)


renderRow {index, model} =
  div
    [class "field__row"]
    (List.map (renderCell index) model)


renderCell rowIndex {index, model} =
  App.map (Click rowIndex index) (Cell.view model)
