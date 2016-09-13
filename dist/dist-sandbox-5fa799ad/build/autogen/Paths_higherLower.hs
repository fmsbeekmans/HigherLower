{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_higherLower (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/mnt/data/src/hs/higherLower/.cabal-sandbox/bin"
libdir     = "/mnt/data/src/hs/higherLower/.cabal-sandbox/lib/x86_64-linux-ghc-8.0.1/higherLower-0.1.0.0-5kMBetj4NQbVieQFdiVBX"
datadir    = "/mnt/data/src/hs/higherLower/.cabal-sandbox/share/x86_64-linux-ghc-8.0.1/higherLower-0.1.0.0"
libexecdir = "/mnt/data/src/hs/higherLower/.cabal-sandbox/libexec"
sysconfdir = "/mnt/data/src/hs/higherLower/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "higherLower_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "higherLower_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "higherLower_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "higherLower_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "higherLower_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
