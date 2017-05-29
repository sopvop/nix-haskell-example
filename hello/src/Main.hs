{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Snap.Core
import           Snap.Http.Server


main = quickHttpServe $
  writeLBS "Hello world"
