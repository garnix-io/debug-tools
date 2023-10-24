import System.Environment (getArgs)
import System.IO

main :: IO ()
main = do
  args <- getArgs
  hPutStrLn stderr (show args)
