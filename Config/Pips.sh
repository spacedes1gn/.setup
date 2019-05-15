# Define whether or not to install the packages listed below
INSTALL_PIPS=true

# Define packages applications to install
pips=(\
	six \
	-e git+https://github.com/sgratzl/slack-cleaner.git#egg=slack-cleaner
)
