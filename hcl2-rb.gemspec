Gem::Specification.new do |s|
  s.name                  = 'hcl2-rb'
  s.version               = '0.9.1'
  s.files                 = Dir['lib/**/*', 'spec/*', 'README*', 'LICENSE*']
  s.license               = 'MIT'
  s.authors               = ['iveahugeship']
  s.email                 = ['iveahugeship@gmail.com']
  s.homepage              = 'https://github.com/iveahugeship/hcl2-rb'
  s.summary               = 'Ruby common data types formatter to HCL2'
  s.description           = <<-DSC
    Ruby common data types formatter to HCL2.

    Using this tool you can format general Ruby data types to HCL2.
    Execute .to_hcl2 method, get the string and write it to a file.
  DSC
  s.required_ruby_version = '>= 2.6.0'
end
