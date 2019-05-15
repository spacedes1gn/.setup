if [[ $INSTALL_VALET == true ]]; then
  valet install
fi

if [ -d ~/.composer/vendor/laravel/valet ]; then
  if [[ $CONFIGURE_VALET ]]; then
    [ -d $VALET_PATH ] || mkdir $VALET_PATH

    valet park $VALET_PATH

    valet tld $VALET_TLD
  fi
fi
