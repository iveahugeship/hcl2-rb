require 'spec_helper'

RSpec.describe Numeric do
  it 'format Numeric to_hcl2' do
    expect(12_345.to_hcl2).to eq('12345')
  end
end

RSpec.describe String do
  it 'format String to_hcl2' do
    expect('string'.to_hcl2).to eq('"string"')
  end
end

RSpec.describe Symbol do
  it 'format Symbol to_hcl2' do
    expect(:symbol.to_hcl2).to eq('"symbol"')
  end
end

RSpec.describe TrueClass do
  it 'format TrueClass to_hcl2' do
    expect(true.to_hcl2).to eq('true')
  end
end

RSpec.describe FalseClass do
  it 'format FalseClass to_hcl2' do
    expect(false.to_hcl2).to eq('false')
  end
end

RSpec.describe Array do
  it 'format Array to_hcl2' do
    expect([1, 2, 'three'].to_hcl2).to eq('[1, 2, "three"]')
  end
end

RSpec.describe Hash do
  fix = {
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
    },
    advanced: {
      foo: {
        bar: {
          bim: 'bam'
        }
      },
      it: 'works?'
    }
  }

  it 'has child' do
    expect(fix.has_child?).to eq(false)
    expect(fix[:listener].has_child?).to eq(true)
  end

  it 'format Hash to_hcl2' do
    exp = <<~EXP
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

      advanced {
        foo "bar" {
          bim = "bam"

        }

        it = "works?"

      }
    EXP
    puts fix.to_hcl2

    expect(fix.to_hcl2).to eq(exp)
  end
end
