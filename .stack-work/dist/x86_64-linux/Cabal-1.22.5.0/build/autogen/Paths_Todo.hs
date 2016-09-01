module Paths_Todo (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/frank/CODE/Todo/.stack-work/install/x86_64-linux/lts-6.14/7.10.3/bin"
libdir     = "/home/frank/CODE/Todo/.stack-work/install/x86_64-linux/lts-6.14/7.10.3/lib/x86_64-linux-ghc-7.10.3/Todo-0.1.0.0-IpKjDdVbKs8326hsSNRKrL"
datadir    = "/home/frank/CODE/Todo/.stack-work/install/x86_64-linux/lts-6.14/7.10.3/share/x86_64-linux-ghc-7.10.3/Todo-0.1.0.0"
libexecdir = "/home/frank/CODE/Todo/.stack-work/install/x86_64-linux/lts-6.14/7.10.3/libexec"
sysconfdir = "/home/frank/CODE/Todo/.stack-work/install/x86_64-linux/lts-6.14/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Todo_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Todo_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Todo_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Todo_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Todo_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
