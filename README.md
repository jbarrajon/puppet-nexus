# puppet-nexus

This module handles the installation & configuration of Sonatype Nexus.

It will automatically manage the nexus user & group, directories, configuration file and service.

The classes are self-descriptive and you can choose what to manage with this module.

## Usage

The default configuration template will work with Nexus versions 2 & 3, just change the `config_options` hash to suit your setup.

The default service template is for systemd, but you can pass your own template & options using the provided service parameters.

## Requirements

Should work fine with Puppet version 3 and above.

No explicit requirement of java, you have to install this yourself.

Requires the modules:
* [`puppet-archive`](https://github.com/voxpupuli/puppet-archive) to handle download & extraction.
* [`puppetlabs-stdlib`](https://github.com/puppetlabs/puppetlabs-stdlib) for parameter verification.

## TODO
* parameter validations
* rspec-puppet unit tests

## Contributing
Pull requests welcome!
