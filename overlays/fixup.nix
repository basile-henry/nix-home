self: super:

{
  # Enable accelerated video decoding
  chromium = super.chromium.override {
    enableVaapi = true;
  };

  # mosh from nixos-20.09 doesn't include a colour fix
  mosh = super.mosh.overrideAttrs (attrs: {
    patches = [
      (builtins.elemAt attrs.patches 0) # ssh patch
      (builtins.elemAt attrs.patches 3) # bash completion patch
    ];

    src = builtins.fetchGit {
      url = "git@github.com:mobile-shell/mosh.git";
      rev = "03087e7a761df300c2d8cd6e072890f8e1059dfa";
    };
  });
}
