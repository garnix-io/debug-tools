import System.Environment (getArgs)

main :: IO ()
main = do
  getArgs >>= print
