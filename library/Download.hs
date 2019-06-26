module Download where

import Env(
  AsAppError(..)
  )

import Control.Lens

import Data.RDF(
  ParseFailure(..),
  RDF,
  AdjHashMap,
  NTriplesParser(..),
  parseURL
  )

import Control.Monad.IO.Class(MonadIO, liftIO)

import Control.Monad.Except(
  MonadError,
  throwError,
  -- runExceptT,
  )

downloadSchema :: (AsAppError e,
                   MonadError e m,
                   MonadIO m
                  ) => String -> m (RDF AdjHashMap)
downloadSchema version = do
  result <- liftIO $ parseURL (NTriplesParser) url
  case result of
    Right rdf -> return (rdf:: RDF AdjHashMap)
    Left (ParseFailure st) -> throwError $ review (asAppParseError) st
  where url = "https://raw.githubusercontent.com/schemaorg/schemaorg/master/data/releases/"<> version <> "/schema.nt"
