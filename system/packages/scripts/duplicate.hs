-- Not fully functional, some packages dont follow the normal naming convention and arent considered
import System.Environment
import Data.Char (isDigit)
import Data.List (isInfixOf , isSuffixOf)
import qualified Data.Set as S

type Name = String
type Version = String
type Pkg = (Name, Version)
type Pkgs = S.Set Pkg

-- Splits only the first occurence
splitOn :: Char -> String -> (String, String)
splitOn delim s = case span (/= delim) (reverse s) of
 (before, []) -> ("", reverse before)
 (before, _:rest) -> (reverse rest, reverse before)

maybeFindMin :: S.Set a -> Maybe a
maybeFindMin s
 | S.null s = Nothing
 | otherwise = Just $ S.findMin s

parsePkg :: String -> (Name, Version)
parsePkg pkg = splitOn '-' $ dropHash $ basename pkg
 where
  basename = reverse . takeWhile (/= '/') . reverse
  dropHash s = case dropWhile (/= '-') s of
   (_:rest) -> rest
   [] -> s

printPkgs :: [String] -> IO()
printPkgs [] = putStr ""
printPkgs (pkg:rest) = do
 putStr $ fst parsed ++ " "
 putStrLn $ snd parsed
 printPkgs rest
 where parsed = parsePkg pkg

parse :: [String] -> Pkgs
parse list = case list of
 [] -> S.empty
 (pkg:rest) -> S.insert (parsePkg pkg) $ parse rest

removeSuffixes :: String -> String
removeSuffixes s =
  case [suf | suf <- suffixes, suf `isSuffixOf` s] of
    (suf:_) -> removeSuffixes (dropSuffix suf s)
    []      -> s
  where
    suffixes = [
     "-data", "-doc", "-docs", "-man", "-dev", "-lib"
     ]
    dropSuffix suf str = take (length str - length suf) str

-- This might be too aggresive in removing packages
-- The ones are the end are workarounds since they dont follow the naming convention
clean :: String -> [String]
clean ins =
 [removeSuffixes l | l <- lines ins, not (null l),
 --isDigit (last l),
 filterOut "perl" l,
 filterOut"python" l,
 filterOut"nixos-system" l,
 filterOut"glibc" l
 ]
 where filterOut s l = not $ isInfixOf s l

isValidVersion :: Pkg -> Bool
isValidVersion (_,version) = case version of
 "" -> False
 (v:vs) -> not (null vs) && isDigit v && all (\c -> isDigit c || c `elem` ".-") vs

-- Version checking could be done at a different point for clarity
getDupes :: Int -> Pkgs -> [Pkgs]
getDupes depth pkgs = case maybeFindMin pkgs of
 Nothing -> []
 Just x  -> [byNameValid | S.size byNameValid >= depth] ++ getDupes depth rest
  where
   byName = S.filter (\p -> fst p == fst x) pkgs
   rest   = pkgs S.\\ byName
   byNameValid = S.filter (isValidVersion) byName -- Filtered separate to avoid errors

-- Very similar to printPkg, could be joined
printDupe :: Pkgs -> IO ()
printDupe pkgs = case maybeFindMin pkgs of
 Nothing -> return ()
 Just (_, version) -> do
  putStrLn version
  printDupe (S.deleteMin pkgs)  -- deleteMin is safe because we checked

printDupes :: [Pkgs] -> IO()
printDupes [] = putStr ""
printDupes (x:xs) = case maybeFindMin x of
 Nothing -> putStr ""
 Just (name, _) -> do
  putStrLn $ "Dupe versions for:" ++ name
  printDupe x
  putStrLn "-------------------------"
  printDupes xs

printHelp :: IO()
printHelp = do
 progName <- getProgName
 putStrLn $ "Usage: " ++ progName ++" <n> <help> where n is the minimium number of duplicates"
 putStrLn "Pipe the results of querying the nix store into this program"
 putStrLn $ "Run: " ++ progName ++ " help, to see this page"

handleArgs :: [String] -> String -> IO()
handleArgs args input = case args of
 [] -> run 2
 ["help"] -> printHelp
 [n]
  | all isDigit n && not (null n) -> run (read n :: Int)
 xs -> putStrLn $ "Unknown or too many args: " ++ show xs
 where run x = printDupes $ getDupes x $ parse $ clean input

main :: IO()
main = do
 args <- getArgs
 input <- getContents
 handleArgs args input
