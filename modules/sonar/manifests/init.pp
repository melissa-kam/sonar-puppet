$jdbc = {
  url               => 'jdbc:postgresql://localhost/sonar',
  username          => 'sonar',
  password          => 'sonar',
}


class { 'java': }
class { 'sonarqube':
  version => '4.3.2',
  jdbc => $jdbc,

}


sonarqube::plugin{'sonar-scm-activity':
    groupid => 'org.codehaus.sonar-plugins.scm-activity',
    artifactid => 'sonar-scm-activity-plugin',
    version => '1.8',
    notify => Service['sonar'],
}

sonarqube::plugin{'sonar-python-plugin':     
    groupid => 'org.codehaus.sonar-plugins.python',
    artifactid => 'sonar-python-plugin',
    version => '1.3',
    notify => Service['sonar'],
}


class { 'postgresql::server':
    postgres_password => 'postgres',
}

postgresql::server::db{ 'sonar':
    user => $jdbc['username'],
    password => postgresql_password($jdbc['username'], $jdbc['password']),
}

class { 'python':
    pip => true
}

python::pip { 'pylint':
    pkgname => 'pylint'
}

