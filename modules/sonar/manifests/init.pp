class { 'postgresql::globals': }
class { 'java': }
class { 'maven::maven' : } ->
class { 'sonarqube' :
  version => '4.3.2',
  user => 'sonar',
  group => 'sonar',
  service => 'sonar'
}
