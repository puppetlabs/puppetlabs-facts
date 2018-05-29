
# facts

#### Table of Contents

1. [Description](#description)
2. [Requirements](#requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Getting help - Some Helpful commands](#getting-help)

## Description

This module provides the facts task. This task allows you to discover facts about remote machines in your infrastructure.

## Requirements

This module is compatible with Puppet Enterprise and Puppet Bolt.

* To run tasks with Puppet Enterprise, PE 2017.3 or later must be installed on the machine from which you are running task commands. Machines receiving task requests must be Puppet agents.

* To run tasks with Puppet Bolt, Bolt 0.5 or later must be installed on the machine from which you are running task commands. Machines receiving task requests must have SSH or WinRM services enabled.

## Usage

To run a facts task use the task command, specifying the fact you want to retrieve.

* With PE on the command line, run `puppet task run facts fact=<FACT>`.
* With Bolt on the command line, run `bolt task run facts fact=<FACT>`.

For example, to check the operating system family on a machine, run:

* With PE, run `puppet task run facts fact=osfamily --nodes neptune`
* With Bolt, run `bolt task run facts fact=osfamily --nodes neptune --modulepath ~/modules`

You can also run tasks in the PE console. See PE task documentation for complete information.

## Reference

To view the available actions and parameters, on the command line, run `puppet task show facts` or see the facts module page on the [Forge](https://forge.puppet.com/puppetlabs/facts/tasks).

For a complete list of facts that are supported, see the Puppet [core facts](https://docs.puppet.com/facter/latest/core_facts.html) documentation.

## Getting Help

To display help for the facts task, run `puppet task show facts`

To show help for the task CLI, run `puppet task run --help` or `bolt task run --help`

