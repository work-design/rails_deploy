Gem::Specification.new do |s|
  s.name = 'rails_deploy'
  s.version = '0.6.4'
  s.authors = ['Mingyuan Qin']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_deploy'
  s.summary = 'Deploy from server'
  s.description = 'Deploy from server'
  s.license = 'MIT'

  s.files = Dir[
    '{lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
end
