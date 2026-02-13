import Data.ByteString (hGetSome, length, null)
import System.Environment (getArgs)
import System.IO
import Prelude hiding (length, null)

main :: IO ()
main = do
  chunk <- hGetSome stdin (100 * 2 ^ 10)
  if null chunk
    then do
      hPutStrLn stderr "stdin closed"
    else do
      hPutStrLn stderr $ "received " <> show (length chunk) <> " bytes: " <> show chunk
      main
