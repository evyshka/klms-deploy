local keycloak_operator = {  
  kc_auth: [
    {
      apiVersion: 'v1',
      kind: 'ServiceAccount',
      metadata: {
        annotations: {
          'app.quarkus.io/build-timestamp': '2023-07-11 - 15:03:21 +0000',
        },
        labels: {
          'app.kubernetes.io/managed-by': 'quarkus',
          'app.kubernetes.io/name': 'keycloak-operator',
          'app.kubernetes.io/version': '22.0.0',
        },
        name: 'keycloak-operator',
      },
    },
    {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'ClusterRole',
      metadata: {
        name: 'keycloakrealmimportcontroller-cluster-role',
      },
      rules: [
        {
          apiGroups: [
            'k8s.keycloak.org',
          ],
          resources: [
            'keycloakrealmimports',
            'keycloakrealmimports/status',
            'keycloakrealmimports/finalizers',
          ],
          verbs: [
            'get',
            'list',
            'watch',
            'patch',
            'update',
            'create',
            'delete',
          ],
        },
      ],
    },
    {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'ClusterRole',
      metadata: {
        name: 'keycloakcontroller-cluster-role',
      },
      rules: [
        {
          apiGroups: [
            'k8s.keycloak.org',
          ],
          resources: [
            'keycloaks',
            'keycloaks/status',
            'keycloaks/finalizers',
          ],
          verbs: [
            'get',
            'list',
            'watch',
            'patch',
            'update',
            'create',
            'delete',
          ],
        },
      ],
    },
    {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'Role',
      metadata: {
        name: 'keycloak-operator-role',
      },
      rules: [
        {
          apiGroups: [
            'apps',
            'extensions',
          ],
          resources: [
            'statefulsets',
          ],
          verbs: [
            'get',
            'list',
            'watch',
            'create',
            'delete',
            'patch',
            'update',
          ],
        },
        {
          apiGroups: [
            '',
          ],
          resources: [
            'secrets',
            'services',
          ],
          verbs: [
            'get',
            'list',
            'watch',
            'create',
            'delete',
            'patch',
            'update',
          ],
        },
        {
          apiGroups: [
            'batch',
          ],
          resources: [
            'jobs',
          ],
          verbs: [
            'get',
            'list',
            'watch',
            'create',
            'delete',
            'patch',
            'update',
          ],
        },
        {
          apiGroups: [
            'networking.k8s.io',
          ],
          resources: [
            'ingresses',
          ],
          verbs: [
            'get',
            'list',
            'watch',
            'create',
            'delete',
            'patch',
            'update',
          ],
        },
      ],
    },
    {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'RoleBinding',
      metadata: {
        labels: {
          'app.kubernetes.io/name': 'keycloak-operator',
        },
        name: 'keycloak-operator-role-binding',
      },
      roleRef: {
        kind: 'Role',
        apiGroup: 'rbac.authorization.k8s.io',
        name: 'keycloak-operator-role',
      },
      subjects: [
        {
          kind: 'ServiceAccount',
          name: 'keycloak-operator',
        },
      ],
    },
    {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'RoleBinding',
      metadata: {
        name: 'keycloakrealmimportcontroller-role-binding',
      },
      roleRef: {
        kind: 'ClusterRole',
        apiGroup: 'rbac.authorization.k8s.io',
        name: 'keycloakrealmimportcontroller-cluster-role',
      },
      subjects: [
        {
          kind: 'ServiceAccount',
          name: 'keycloak-operator',
        },
      ],
    },
    {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'RoleBinding',
      metadata: {
        name: 'keycloakcontroller-role-binding',
      },
      roleRef: {
        kind: 'ClusterRole',
        apiGroup: 'rbac.authorization.k8s.io',
        name: 'keycloakcontroller-cluster-role',
      },
      subjects: [
        {
          kind: 'ServiceAccount',
          name: 'keycloak-operator',
        },
      ],
    },
    {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'RoleBinding',
      metadata: {
        name: 'keycloak-operator-view',
      },
      roleRef: {
        kind: 'ClusterRole',
        apiGroup: 'rbac.authorization.k8s.io',
        name: 'view',
      },
      subjects: [
        {
          kind: 'ServiceAccount',
          name: 'keycloak-operator',
        },
      ],
    },
  ],


  kc_svc: {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      annotations: {
        'app.quarkus.io/build-timestamp': '2023-07-11 - 15:03:21 +0000',
      },
      labels: {
        'app.kubernetes.io/name': 'keycloak-operator',
        'app.kubernetes.io/version': '22.0.0',
        'app.kubernetes.io/managed-by': 'quarkus',
      },
      name: 'keycloak-operator',
    },
    spec: {
      ports: [
        {
          name: 'http',
          port: 80,
          protocol: 'TCP',
          targetPort: 8080,
        },
      ],
      selector: {
        'app.kubernetes.io/name': 'keycloak-operator',
        'app.kubernetes.io/version': '22.0.0',
      },
      type: 'ClusterIP',
    },
  },

  kc_deployment: {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      annotations: {
        'app.quarkus.io/build-timestamp': '2023-07-11 - 15:03:21 +0000',
      },
      labels: {
        'app.kubernetes.io/managed-by': 'quarkus',
        'app.kubernetes.io/name': 'keycloak-operator',
        'app.kubernetes.io/version': '22.0.0',
      },
      name: 'keycloak-operator',
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          'app.kubernetes.io/name': 'keycloak-operator',
          'app.kubernetes.io/version': '22.0.0',
        },
      },
      template: {
        metadata: {
          annotations: {
            'app.quarkus.io/build-timestamp': '2023-07-11 - 15:03:21 +0000',
          },
          labels: {
            'app.kubernetes.io/managed-by': 'quarkus',
            'app.kubernetes.io/name': 'keycloak-operator',
            'app.kubernetes.io/version': '22.0.0',
          },
        },
        spec: {
          containers: [
            {
              env: [
                {
                  name: 'KUBERNETES_NAMESPACE',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'metadata.namespace',
                    },
                  },
                },
                {
                  name: 'OPERATOR_KEYCLOAK_IMAGE',
                  value: 'quay.io/keycloak/keycloak:22.0.0',
                },
              ],
              image: 'quay.io/keycloak/keycloak-operator:22.0.0',
              imagePullPolicy: 'Always',
              livenessProbe: {
                failureThreshold: 3,
                httpGet: {
                  path: '/q/health/live',
                  port: 8080,
                  scheme: 'HTTP',
                },
                initialDelaySeconds: 5,
                periodSeconds: 10,
                successThreshold: 1,
                timeoutSeconds: 10,
              },
              name: 'keycloak-operator',
              ports: [
                {
                  containerPort: 8080,
                  name: 'http',
                  protocol: 'TCP',
                },
              ],
              readinessProbe: {
                failureThreshold: 3,
                httpGet: {
                  path: '/q/health/ready',
                  port: 8080,
                  scheme: 'HTTP',
                },
                initialDelaySeconds: 5,
                periodSeconds: 10,
                successThreshold: 1,
                timeoutSeconds: 10,
              },
              startupProbe: {
                failureThreshold: 3,
                httpGet: {
                  path: '/q/health/started',
                  port: 8080,
                  scheme: 'HTTP',
                },
                initialDelaySeconds: 5,
                periodSeconds: 10,
                successThreshold: 1,
                timeoutSeconds: 10,
              },
            },
          ],
          serviceAccountName: 'keycloak-operator',
        },
      },
    },
  },
};

local keycloak_realm = {

  play_realm: {

  }

};

local pg = import "postgresql.libsonnet";

{
  //postgres: pg.new($._config.namespace).setDataStorageSize('2Gi')
  postgres: pg.new({
    namespace:'playground',
    values: {
      auth: {
        postgresPassword: 'st3l@r',
        database: 'vsam',
        user: 'vsam',
        password: 'vsam_st3l@r'
      },
      primary: {
        persistence: { 
          size: '3Gi',
          storageClass: 'longhorn',
        }
      }
    }
  }),

}
