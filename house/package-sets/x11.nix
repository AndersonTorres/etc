{ pkgs }:

with pkgs; [
  xorg.xf86inputevdev
	xorg.xf86videoamd
	xorg.xf86inputsynaptics
	xorg.xorgserver  
	xorg.fontmiscmisc
	ucsFonts
]
