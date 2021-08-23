self: super:

{
  # mosh from nixos-20.09 doesn't include a colour fix
  mosh = super.mosh.overrideAttrs (attrs: {
    patches = [
      (builtins.elemAt attrs.patches 0) # ssh patch
      (builtins.elemAt attrs.patches 4) # bash completion patch
    ];

    src = builtins.fetchGit {
      url = "ssh://git@github.com/mobile-shell/mosh.git";
      ref = "master";
      rev = "e023e81c08897c95271b4f4f0726ec165bb6e1bd";
    };
  });
}
