;;; -*- lexical-binding: t; no-byte-compile: t -*-

(define-skeleton skel-nixpkgs-mkderivation
  "Skeleton for a typical mkDerivation."
  nil
  "{ lib" > \n
  ", stdenv" > \n
  "}:" > \n
  "" > \n
  "stdenv.mkDerivation rec {" > \n
  "pname = \"" (skeleton-read "pname:> ") "\";" > \n
  "version = \"" (skeleton-read "version:> ") "\";" > \n
  "" > \n
  "}" > \n
)

(define-skeleton skel-nixpkgs-src-fetchurl
  "Skeleton for a typical fetchurl."
  nil
  "src = fetchurl {" > "\n"
  "url = " ?\" (skeleton-read "URL> ") ?\" ";" > "\n"
  "hash = " ?\" (skeleton-read "hash> ") | "${lib.fakeHash}" ?\" ";" > "\n"
  "};" > "\n")

(define-skeleton skel-nixpkgs-src-github
  "Skeleton for a typical fetchFromGitHub."
  nil
  "src = fetchFromGitHub {" > "\n"
  "owner = " ?\" (skeleton-read "owner> ") ?\" ";" > "\n"
  "repo = " ?\" (skeleton-read "repo> ") ?\" ";" > "\n"
  "rev = " ?\" (skeleton-read "rev> ") ?\" ";" > "\n"
  "hash = " ?\" (skeleton-read "hash> ") | "${lib.fakeHash}" ?\" ";" > "\n"
  "};" > "\n")

(define-skeleton skel-nixpkgs-meta
  "Skeleton for a typical meta."
  nil
  "meta = with lib; {" > "\n"
  "homepage = " ?\" (skeleton-read "homepage> ") ?\" ";" > "\n"
  "description = " ?\" (skeleton-read "description> ") ?\" ";" > "\n"
  "license = licenses." (skeleton-read "license> ") ";" > "\n"
  "maintainers = with maintainers; [ " (skeleton-read "maintainers> ") " ];" > "\n"
  "platforms = with platforms; " (skeleton-read "platforms> ") ";" > "\n"
  "};" > \n
)
