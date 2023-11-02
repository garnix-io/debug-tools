import Control.Concurrent (threadDelay)
import Control.Monad (forM_, forever)
import Data.Map (Map, keys, singleton, toList, (!))
import Foreign.C (CInt)
import System.IO (hPutStrLn, stderr)
import System.Posix.Signals

main :: IO ()
main = do
  forM_ (toList allSignals) $ \(sig, name) -> do
    let handler = do
          hPutStrLn
            stderr
            ("received signal: " <> name <> " (" <> show sig <> ")")
    installHandler sig (Catch handler) Nothing
  hPutStrLn stderr "listening for signals..."
  forever $ threadDelay (10 ^ 6)

(~>) :: key -> value -> Map key value
(~>) = singleton

allSignals =
  mempty
    <> (nullSignal ~> "null signal")
    <> (sigABRT ~> "SIGABRT")
    <> (sigALRM ~> "SIGALRM")
    <> (sigBUS ~> "SIGBUS")
    <> (sigCHLD ~> "SIGCHLD")
    <> (sigCONT ~> "SIGCONT")
    <> (sigFPE ~> "SIGFPE")
    <> (sigHUP ~> "SIGHUP")
    <> (sigILL ~> "SIGILL")
    <> (sigINT ~> "SIGINT")
    <> (sigKILL ~> "SIGKILL")
    <> (sigPIPE ~> "SIGPIPE")
    <> (sigQUIT ~> "SIGQUIT")
    <> (sigSEGV ~> "SIGSEGV")
    <> (sigSTOP ~> "SIGSTOP")
    <> (sigTERM ~> "SIGTERM")
    <> (sigTSTP ~> "SIGTSTP")
    <> (sigTTIN ~> "SIGTTIN")
    <> (sigTTOU ~> "SIGTTOU")
    <> (sigUSR1 ~> "SIGUSR1")
    <> (sigUSR2 ~> "SIGUSR2")
    <> (sigPOLL ~> "SIGPOLL")
    <> (sigPROF ~> "SIGPROF")
    <> (sigSYS ~> "SIGSYS")
    <> (sigTRAP ~> "SIGTRAP")
    <> (sigURG ~> "SIGURG")
    <> (sigVTALRM ~> "SIGVTALRM")
    <> (sigXCPU ~> "SIGXCPU")
    <> (sigXFSZ ~> "SIGXFSZ")
