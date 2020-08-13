[![](https://images.microbadger.com/badges/image/degauss/geocoder.svg)](https://microbadger.com/images/degauss/geocoder "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/degauss/geocoder.svg)](https://microbadger.com/images/degauss/geocoder "Get your own version badge on microbadger.com")
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.344621.svg)](https://doi.org/10.5281/zenodo.344621)

# geocoder

> A geocoder that relies on offline TIGER/Line data useful for geocoding private health information.

See [geocoding documentation](http://colebrokamp.com/posts/geocoding_tips.html) for a description of how this service works and advice for getting and using the best results.

## Traditional Installation

This software was designed and tested on Linux Ubuntu. The following install instructions are for Ubuntu. CentOS install instructions are also below, but are not throughly tested.

### Requirements

Install required software:

	sudo apt-get install sqlite3 libsqlite3-dev flex ruby-full libssl-dev libssh2-1-dev libcurl4-openssl-dev curl libxml2-dev

Install ruby gems:

	sudo gem install sqlite3
	sudo gem install json
	sudo gem install Text
	sudo gem install sinatra


### Download and Install

Download the git repo to the home directory and then compile the SQLite3 extension and the Geocoder-US Ruby gem:

    cd ~
	git clone git@github.com:simonsfoundation/geocoder.git
    cd geocoder
    sudo make install
    sudo gem install Geocoder-US-2.0.4.gem

### TIGER/Line Database

The program relies on a sqlite3 database created from TIGER/Line files that is about 4.6 GB. Download the compiled database based on 2015 TIGER/Line files into the `/opt` directory so it is accessible by all users.

	sudo wget https://colebrokamp-dropbox.s3.amazonaws.com/geocoder.db -P /opt


Alternatively, build your own database (see the section below for details).


## Usage

#### Geocoding

The program takes in one character string and parses address components in order to search the database.  To geocode an address, call ruby to run the program with the address string as the argument:

	ruby ~/geocoder/bin/geocode.rb "3333 Burnet Ave Cincinnati Ohio 45229"

This results in a file called `temp.json` being written to the current directory with the results. It is possible to pipe this output into another file, but the user will likely be geocoding more than one file at a time, using batch geocoding.

The `geocode.R` program uses the `argparser` package to take in command line arguments which define both the name of the CSV file and name of the column in that file which contain the address strings.

#### Running Geocoding as Service

	ruby lib/geocoder/us/rest.rb /opt/geocoder.db

	http://localhost:8081/geocode.json?q=3333%20Burnet%20Ave%20Cincinnati%20Ohio%2045229

