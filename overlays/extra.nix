self: super:

{
  base16-shell = builtins.fetchGit {
    url = "https://github.com/chriskempson/base16-shell.git";
    ref = "master";
    rev = "ce8e1e540367ea83cc3e01eec7b2a11783b3f9e1";
  };
}
