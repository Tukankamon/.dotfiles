module Config where
import Utils

tab :: String
tab = "\t"

data Language = Default | Rust | Haskell
data Nixpkgs = Stable | Unstable
data Arch = X86 -- #TODO add more
data Data = Data {arch :: Arch, lang :: Language, branch :: Nixpkgs}
data Config  = Config { definitions :: [String], packages :: [String], hook :: [String] } deriving (Show)

branchToString :: Nixpkgs -> String
branchToString br = case br of
  Stable -> "nixos-25.11"
  Unstable -> "nixos-unstable"

archToString :: Arch -> String
archToString architechture = case architechture of
  X86 -> "x86_64-linux"

fillConfig :: Data -> Config
fillConfig dat = case lang dat of
  Default -> Config {
    definitions = [pkgs],
    packages = [""],
    hook = ["fish"] }
  Rust -> Config {
    definitions = [pkgs],
    packages = ["cargo", "rustc"],
    hook = [] }
  Haskell -> Config {
    definitions = [pkgs, hpkgs],
    packages = ["ghc", "cabal-install"],
    hook = [] }
  where
    pkgs = catDot ["pkgs = nixpkgs.legacyPackages", archToString (arch dat)] ++ ";"
    hpkgs = "hpkgs = pkgs.haskellPackages;"
