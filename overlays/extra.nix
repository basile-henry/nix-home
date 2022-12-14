self: super:

{
  base16-shell = builtins.fetchTarball {
    url = "https://github.com/chriskempson/base16-shell/archive/refs/heads/master.tar.gz";
    sha256 = "0w8g0gyvahkm6zqlwy6lw9ac3hragwh3hvrnvvq2082hdyq4bksz";
  };
}
