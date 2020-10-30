
# lcmaps

#### Table of Contents

1. [Description](#description)
2. [Setup](#setup)
3. [Usage](#usage)
4. [Limitations](#limitations)

## Description

Install and configure LCMAPS.

## Setup

This module is available on puppet forge:

```
puppet module install cnafsd-lcmaps
```

## Usage

Use this module as follow:

```puppet
include lcmaps
```

If you want to define your own pool accounts use:

```puppet
class { 'lcmaps':
  pools => [
    {
      'name' => 'poolname',
      'size' => 200,
      'base_uid' => 1000,
      'group' => 'poolgroup',
      'gid' => 1000,
      'vo' => 'poolVO',
    },
  ],
}
```

Pool accounts mandatory data:

* name, the name of the pool;
* size, the size of pool;
* base_uid, the first uid of the generated accounts;
* group, the name of the promary group of each account;
* gid, the group id of the primary group;
* vo, the VO name.

Optional parameters:

* groups, non primary groups for each account;
* role, the VOMS role (if not defined is NULL);
* capability, the VOMS capability (if not defined is NULL).

## Limitations

It works only on RedHat CentOS 7 distributions.