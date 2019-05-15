# Define whether or not to install the taps, bottles and pins listed below
TAP_BOTTLES=true
INSTALL_BOTTLES=true
PIN_BOTTLES=true

# Define bottles to tap
taps=(\
 # Required for installing drivers
 caskroom/drivers \
 # Required for installing fonts
 caskroom/fonts \
 # Required for installing specific versions of bottles
 caskroom/versions \
)

# Define bottles to install
# Simply comment out un-wanted bottles
bottles=(\
	node \
	npm \
	yarn \
	php \
	composer \
	mysql \
	python \
	wget \
	curl \
	git \
	docker \
	docker-machine \
	docker-compose \
	zsh \
)

# Define bottles to pin
pins=(\
 mysql \
)
