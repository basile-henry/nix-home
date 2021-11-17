self: super:

{
  base16-shell = builtins.fetchTarball {
    url = "https://github.com/chriskempson/base16-shell/archive/refs/heads/master.tar.gz";
    sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
  };
}
