# PM2 Cookbook

Chef coookbook to install and manage [PM2](https://github.com/Unitech/pm2).

## Requirements

Depends on the cookbooks:

 * [nodejs](https://github.com/redguide/nodejs/)

## Platforms

 * Centos 6+
 * Amazon Linux

## Attributes

### default.rb

- `node['pm2']['version']` - Defines the pm2 node module version to install. Default is the latest version.

### nodejs.rb

These attributes are passed to the `nodejs` cookbook and override the default values.

- `node['pm2']['nodejs']['install_method']` - Defines: nodejs install method - Options: `package`, `source`, `binary` - Default: `package`
- `node['pm2']['nodejs']['npm']['install_method']` - Defines: npm install method - Options: `embedded`, `source` - Default: `embedded`

## Recipes

### default.rb

Installs pm2 as a global node module using a specific version if specified in the `default` attributes described above.

### nodejs.rb

Install `nodejs` and `npm` using the [nodejs](https://github.com/redguide/nodejs/) and overriding the default installation methods with the ones defined in the `nodejs` attributes described above.

## Providers

TODO

## Development / Contributing

### Tests

This assumes you're using [chef-dk](https://downloads.getchef.com/chef-dk/).

To run unit tests using chefspec you can run:
```bash
$ chef exec rspec
```

To run integration tests using kitchen-ci and serverspec you can run:
```bash
$ chef exec kitchen test
```

