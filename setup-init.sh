#!/bin/bash
package_name=$1
mkdir $package_name

cd $package_name
composer init