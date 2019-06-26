{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}

module Env where

import Control.Lens

import Control.Monad.Except(
  ExceptT,
  MonadError,
  -- throwError,
  runExceptT,
  )

import Control.Monad.IO.Class(MonadIO)

class AsAppError a where
  asAppError :: Prism' a AppError
  asAppParseError :: Prism' a String

  asAppParseError = asAppError . asAppParseError

data AppError = AppParseError { _appParseError :: String} |
                OtherError
  deriving (Show)

instance AsAppError AppError where
  asAppError = id
  asAppParseError = prism' AppParseError (\ case AppParseError s -> Just s
                                                 _ -> Nothing)

newtype AppT m a = AppT
  {
    -- unAppT:: (ReaderT AppState (ExceptT AppError m)) a
    unAppT:: (ExceptT AppError m) a

  } deriving
  (
    Functor,
    Applicative,
    Monad,
    -- MonadReader AppState,
    MonadError AppError,
    MonadIO
  )

runAppT :: (AppT IO ()) -> IO ()
runAppT app = do
  -- let except = runReaderT reader appState
  runResult <- runExceptT except
  case runResult of
    Left e -> case preview asAppParseError e of
                Just s -> putStrLn $ "There was a parse error with this release: " <> s
                Nothing -> putStrLn $ "There was an unknown error" <> show e
    Right a -> return a

  where except = unAppT app
