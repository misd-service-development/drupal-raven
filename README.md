Raven authentication
====================

[![Build Status](https://travis-ci.org/misd-service-development/drupal-raven.svg?branch=master)](https://travis-ci.org/misd-service-development/drupal-raven)

This module allows users to log into a Drupal site using [Raven](http://raven.cam.ac.uk/), the University of Cambridge's central authentication service.

Users can log into an existing account assuming their CRSid has been used as their username, otherwise a new account is created (if your site allows visitors to create accounts). In order to login using Raven the user must visit sitename.cam.ac.uk/raven/login

Authors
-------

* Chris Wilkinson <chris.wilkinson@admin.cam.ac.uk>

It is based on the [Ucamraven module](https://wiki.cam.ac.uk/raven/Drupal#ucamraven) and uses code from the [UcamWebauth PHP class](https://wiki.cam.ac.uk/raven/PHP_library).

Requirements
------------

* [PHP OpenSSL library](http://www.php.net/manual/en/book.openssl.php)
* Drupal 7
