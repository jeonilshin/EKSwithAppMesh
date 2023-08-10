#!/bin/bash
kubectl delete all --all -n yelb

export AUTOSCALING_GROUP=$(aws eks describe-nodegroup --cluster-name skills-cluster --nodegroup-name skills-mesh-ng | jq -r '.nodegroup.resources.autoScalingGroups[0].name' | sed 's/-skills-mesh-ng//')
export ROLE_NAME=$(aws iam get-instance-profile --instance-profile-name $AUTOSCALING_GROUP | jq -r '.InstanceProfile.Roles[] | .RoleName')
aws iam detach-role-policy \
--role-name $ROLE_NAME \
--policy arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess

eksctl delete cluster -f cluster.yml

aws cloudformation delete-stack --stack-name skills-infra