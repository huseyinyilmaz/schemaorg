module MainApp where

import App (app)
import Env (runAppT)

main :: IO ()
main = runAppT app
