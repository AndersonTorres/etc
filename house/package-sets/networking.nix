{ pkgs }:

let
  wee-chat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with pkgs.weechatScripts; [
        wee-slack
        weechat-matrix
      ];
    };
  };

  browsers = with pkgs; [
    brave
    chromium
    elinks
    # firefox
    # luakit
    # palemoon
    # webmacs
  ];

  irc = with pkgs; [
    hexchat
    # irssi
    wee-chat
  ];

  torrent = with pkgs; [
    mktorrent
    rtorrent
  ];

  misc = with pkgs; [
    #tartube-yt-dlp
    ncftp
    yt-dlp
  ];
in
[]
++ misc
++ browsers
++ irc
++ torrent
