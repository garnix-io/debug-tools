import Control.Exception (ErrorCall (ErrorCall), throwIO)
import Control.Monad (forM_)
import Foreign.C.Types
import System.IO (hPutStrLn, stderr)
import System.Posix.Internals (c_isatty)
import Prelude hiding (log)

main :: IO ()
main = do
  forM_ streams $ \(number, name) -> do
    result <- c_isatty number
    case result of
      0 -> log (name <> " is not a tty")
      1 -> log (name <> " is a tty")
      _ -> throwIO $ ErrorCall $ "unexpected result: " <> show result

streams :: [(CInt, String)]
streams =
  [ (0, "stdin "),
    (1, "stdout"),
    (2, "stderr")
  ]

log :: String -> IO ()
log = hPutStrLn stderr
