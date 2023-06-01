require 'spec_helper'

RSpec.describe Numeric do
  it 'format to hcl2' do
    expect(12_345.to_hcl2).to eq('12345')
  end
end

RSpec.describe String do
  it 'format to hcl2' do
    expect('string'.to_hcl2).to eq('"string"')
  end
end

RSpec.describe Symbol do
  it 'format to hcl2' do
    expect(:symbol.to_hcl2).to eq('"symbol"')
  end
end

RSpec.describe TrueClass do
  it 'format to hcl2' do
    expect(true.to_hcl2).to eq('true')
  end
end

RSpec.describe FalseClass do
  it 'format to hcl2' do
    expect(false.to_hcl2).to eq('false')
  end
end

RSpec.describe Array do
  it 'format to hcl2' do
    expect([1, 2, 'three'].to_hcl2).to eq('[1, 2, "three"]')
  end
end

RSpec.describe Hash do
  fixture = {
    ui: true,
    listener: {
      tcp: {
        address: '0.0.0.0:8200'
      },
      unix: {
        address: '/run/vault.sock'
      }
    }
  }

  expectation = <<~EXP
    ui = true

    listener "tcp" {
      address = "0.0.0.0:8200"

    }

    listener "unix" {
      address = "/run/vault.sock"

    }
  EXP

  it 'check childs' do
    expect(fixture[:listener].has_child?).to eq(true)
    expect(fixture[:listener][:tcp].has_child?).to eq(false)
  end

  it 'format to hcl2' do
    expect(fixture.to_hcl2).to eq(expectation)
  end
end

RSpec.describe 'Advanced cases' do
  it 'check array objects formating' do
    fixture = {
      listener: [{
        tcp: {
          address: '0.0.0.0:8200'
        }
      }, {
        tcp: {
          address: '127.0.0.1:8201'
        }
      }]
    }

    expectation = <<~EXP
      listener "tcp" {
        address = "0.0.0.0:8200"

      }

      listener "tcp" {
        address = "127.0.0.1:8201"

      }
    EXP

    expect(fixture.to_hcl2).to eq(expectation)
  end

  it 'check nested object' do
    fixture = {
      resource: {
        openstack_compute_flavor_v2: {
          this: {
            name: 'this',
            region: 'region_a',
            ram: 4,
            vcpus: 2
          }
        },
        openstack_networking_port_v2: {
          this: {
            name: 'this',
            region: 'region_a'
          }
        }
      }
    }

    expectation = <<~EXP
      resource "openstack_compute_flavor_v2" "this" {
        name = "this"

        region = "region_a"

        ram = 4

        vcpus = 2

      }

      resource "openstack_networking_port_v2" "this" {
        name = "this"

        region = "region_a"

      }
    EXP

    expect(fixture.to_hcl2).to eq(expectation)
  end
end

RSpec.describe 'HashiCorp examples' do
  it 'Vault' do
    fixture = {
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

    expectation = <<~EXP
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
    EXP

    expect(fixture.to_hcl2).to eq(expectation)
  end
end
