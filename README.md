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

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Description</th>
        <th>Options</th>
        <th>Default</th>
    </tr>
    <tr>
        <td><tt>['pm2']['version']</tt></td>
        <td>String</td>
        <td>PM2 node module version to install</td>
        <td>-</td>
        <td><tt>latest</tt></td>
    </tr>
</table>

### nodejs.rb

These attributes are used by the `nodejs` cookbook and override the default values.

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Description</th>
        <th>Options</th>
        <th>Default</th>
    </tr>
    <tr>
        <td><tt>['pm2']['nodejs']['install_method']</tt></td>
        <td>String</td>
        <td>Nodejs install method</td>
        <td><tt>package|source|binary</tt></td>
        <td><tt>package</tt></td>
    </tr>
    <tr>
        <td><tt>['pm2']['nodejs']['npm]['install_method']</tt></td>
        <td>String</td>
        <td>NPM install method</td>
        <td><tt>embedded|source</tt></td>
        <td><tt>embedded</tt></td>
    </tr>    
</table>

## Recipes

### default.rb

Installs PM2 as a global node module using a specific version if specified in the `default` attributes described above.

### nodejs.rb

Install `nodejs` and `npm` using the [nodejs](https://github.com/redguide/nodejs/) and overriding the default installation methods with the ones defined in the `nodejs` attributes described above.

## Providers

### pm2_application

The `pm2_application` provider manages a json configuration file for a node application and controls it with PM2. 

It only start processes from a json configuration (located in `/etc/pm2/conf.d`) and it does not support starting processes by calling the PM2 CLI directly.

#### Actions

The available actions try to represent some of the PM2 CLI control [actions](https://github.com/Unitech/PM2/blob/master/ADVANCED_README.md#raw-examples).

<table>
    <tr>
        <th>Action</th>
        <th>Description</th>
        <th>Notes</th>
    </tr>
    <tr>
        <td><tt>:deploy</tt></td>
        <td>Create a json configuration file for a node application</td>
        <td>All configuration files are deployed in <tt>/etc/pm2/conf.d</tt></td>
    </tr>
    <tr>
        <td><tt>:start</tt></td>
        <td>Start an application defined as a json file</td>
        <td>It does not change the state of a running application - use one of the start_or_restart/start_or_reload methods instead</td>
    </tr>
    <tr>
        <td><tt>:stop</tt></td>
        <td>Stop an application</td>
        <td>Invokes the PM2 CLI to stop an application by name</td>
    </tr>
    <tr>
        <td><tt>:stop</tt></td>
        <td>Restart an application</td>
        <td>Invokes the PM2 CLI to restart an application by name only if it is running</td>
    </tr>
    <tr>
        <td><tt>:reload</tt></td>
        <td>Reload an application</td>
        <td>Invokes the PM2 CLI to reload an application by name only if it is running</td>
    </tr>
    <tr>
        <td><tt>:graceful_reload</tt></td>
        <td>Gracefully reload an application</td>
        <td>Invokes the PM2 CLI to gracefully reload an application by name only if it is running</td>
    </tr>
    <tr>
        <td><tt>:start_or_restart</tt></td>
        <td>Start or restart an application</td>
        <td>Invokes the PM2 CLI to start or restart an application by name</td>
    </tr>
    <tr>
        <td><tt>:start_or_reload</tt></td>
        <td>Start or reload an application</td>
        <td>Invokes the PM2 CLI to start or reload an application by name</td>
    </tr>
    <tr>
        <td><tt>:start_or_graceful_reload</tt></td>
        <td>Start or gracefully reload an application</td>
        <td>Invokes the PM2 CLI to start or gracefully reload an application by name</td>
    </tr>
    <tr>
        <td><tt>:delete</tt></td>
        <td>Stop and delete an application json file</td>
        <td>Invokes the PM2 CLI to stop an application and deletes the json file from the filesystem</td>
    </tr>
</table>

#### Attributes

The available attributes try to represent the PM2 json definition options [schema](https://github.com/Unitech/PM2/blob/master/ADVANCED_README.md#schema).

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Description</th>
        <th>Required</th>
    </tr>
    <tr>
        <td><tt>name</tt></td>
        <td>String</td>
        <td>Name of the application - See PM2 documentation for reference - Note: this is the resource name attribute</td>
        <td>Yes</td>
    </tr>
    <tr>
        <td><tt>script</tt></td>
        <td>String</td>
        <td>Node script to execute - See PM2 documentation for reference</td>
        <td>Yes</td>
    </tr>
    <tr>
        <td><tt>args</tt></td>
        <td>Array</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>node_args</tt></td>
        <td>Array</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>max_memory_restart</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>instances</tt></td>
        <td>Integer</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>log_file</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>error_file</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>out_file</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>pid_file</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>cron_restart</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>cwd</tt></td>
        <td>String</td>
        <td>Location of the node script to execute - See PM2 documentation for reference</td>
        <td>Yes</td>
    </tr>
    <tr>
        <td><tt>merge_logs</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>ignore_watch</tt></td>
        <td>Array</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>watch_options</tt></td>
        <td>Hash</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>env</tt></td>
        <td>Hash</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>log_data_format</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>min_uptime</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>max_restart</tt></td>
        <td>Integer</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>exec_mode</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>exec_interpreter</tt></td>
        <td>String</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>write</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>force</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>See PM2 documentation for reference</td>
        <td>No</td>
    </tr>
</table>

#### References

 * PM2 advanced [documentation](https://github.com/Unitech/PM2/blob/master/ADVANCED_README.md)

## Development / Contributing

### Dependencies

 * [Ruby](https://www.ruby-lang.org)
 * [Bundler](http://bundler.io)

### Installation

```bash
$ git clone git@github.com:Mindera/pm2-cookbook.git
$ cd pm2-cookbook
$ bundle install
```

### Tests

To run unit tests (chefspec):
```bash
$ bundle exec rake unit
```

To run lint tests (rubocop, foodcritic):
```bash
$ bundle exec rake unit
```

To run integration tests (kitchen-ci, serverspec):
```bash
$ bundle exec rake integration:vagrant
```
