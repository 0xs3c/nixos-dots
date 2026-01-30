{ ... }:
{
  # Dummy file to allow the flake to evaluate on the main system.
  # This will be replaced during the actual installation.
  fileSystems."/" = { device = "/dev/sda1"; }; 
}
