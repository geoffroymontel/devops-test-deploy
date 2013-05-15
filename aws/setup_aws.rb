require 'yaml'
require 'aws-sdk'

AWS.config(YAML.load_file('aws_credentials.yml'))

ec2 = AWS.ec2

instances = ec2.instances.inject({}) { |m, i| m[i.id] = i.status; m }
puts instances