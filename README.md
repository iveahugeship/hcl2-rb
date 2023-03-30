# hcl2-rb

Ruby common data types formatter to HCL2.

Using this tool you can format general Ruby data types to HCL2.
Execute .to_hcl2 method, get the string and write it to a file

## Example

It's very simple! You have the Hash:

```
vault_config = {
  ui: true,
  listener: {
    tcp: {
      address: '127.0.0.1:8200'
    },
    unix: {
      address: '/run/vault.sock'
    }
  },
  telemetry: {
    statsite_address: 'statsite.company.local:8125'
  }
}
```

Now format it to HCL2:

```
>> puts vault_config.to_hcl2
ui = true

listener "tcp" {
  address = "127.0.0.1:8200"

}

listener "unix" {
  address = "/run/vault.sock"

}

telemetry {
  statsite_address = "statsite.company.local:8125"

}
```

## Contributing

Create a PR or a simple issue c:

Before PR creating, please, execute `rspec` and `rubocop`.
