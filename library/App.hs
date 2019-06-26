module App where
import Control.Monad.IO.Class(liftIO, MonadIO)

import Env (AppT)
import Download(downloadSchema)

app :: (MonadIO m) => AppT m ()
app = do
  schema <- downloadSchema "3.7a"
  liftIO $ print $ show schema
