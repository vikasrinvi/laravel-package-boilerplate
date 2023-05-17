#!/bin/bash


composer_json=$(cat composer.json)

# Extract the namespace using jq
namespace=$(echo "$composer_json" | jq -r '.autoload."psr-4" | to_entries | .[0].key')



# Get the package name from command-line argument
package_name=$2
namespace=$1
# Generate the service provider class name
service_provider_class_name=$(echo "$package_name" | sed -E 's/(-|_)([a-z])/\U\2/g' | sed -E 's/(^|_)([a-z])/\U\2/g')ServiceProvider

# Generate the service provider file name
service_provider_file_name="src/$service_provider_class_name.php"

# Generate the service provider code
service_provider_code="<?php

namespace $namespace/$package_name;

use Illuminate\Support\ServiceProvider;

class $service_provider_class_name extends ServiceProvider
{
    /**
     * Register any package services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any package services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
"

# Create the service provider file
echo "$service_provider_code" > "$service_provider_file_name"

# Display success message
