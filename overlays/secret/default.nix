{pkgs, ...}:
{
      secret = pkgs.buildGoModule {
        pname = "secret";
        name = "secret";
        version = "development";

        vendorSha256 = "sha256-H4xw+8vvCxQG/ZQBSxE62O1wSpICpeXqjXPzNBzZU1Y=";
        src = super.fetchFromGithub {
          owner = "hcssmith";
          repo = "secret";
          rev = "702045e87a9e05551ec3795728556c9242763f22";
          sha256 = "0rs9bxxrw4wscf4a8yl776a8g880m5gcm75q06yx2cn3lw2b7v22";
        };

      };
  } 

