# K3S_INSTALLATION USING TERRAFORM

**First, we will Launch two aws t3a.medium Ubuntu instances (Master and Worker) with Terraform**

**The following ports are allowed for security groups.**
**MASTER NODE Security Group**

| PROTOCOL | PORT      | SOURCE                     | DESCRIPTION|
|----------|-----------|----------------------------|-------------------------------------------------------|
| TCP      | 6443      | K3s agent nodes            | Kubernetes API Server|
| SSH      | 22 | SSH Port           |                |

Typically all outbound traffic is allowed.

**WORKER NODE Security Group**

| PROTOCOL | PORT      | SOURCE                     | DESCRIPTION|
|----------|-----------|----------------------------|-------------------------------------------------------|
| TCP      | 6443      | K3s agent nodes            | Kubernetes API Server|
| SSH      | 22 | SSH Port           |                |

Typically all outbound traffic is allowed.

**Master and Worker scripts are added as userdata to terraform**

- master.sh
- wroker.sh

**End of the task, we will connect to Master node via ssh and run the following command to see the master and worker nodes in the cluster**

```
sudo kubectl get nodes -o wide
```

