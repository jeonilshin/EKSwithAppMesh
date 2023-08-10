#!/bin/bash

# 환경변수 설정
export vpc_id=`aws ec2 describe-vpcs --filters "Name=tag:Name,Values=skills-vpc" --query "Vpcs[0].VpcId" --output text`
export public_a=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*skills-public-a*" --query "Subnets[].SubnetId[]" --output text`
export public_b=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*skills-public-b*" --query "Subnets[].SubnetId[]" --output text`
export private_a=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*skills-private-a*" --query "Subnets[].SubnetId[]" --output text`
export private_b=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*skills-private-b*" --query "Subnets[].SubnetId[]" --output text`

# 클러스터 정보 수정
sed -i "s/vpc_id/$vpc_id/g" cluster.yml
sed -i "s/public_a/$public_a/g" cluster.yml
sed -i "s/public_b/$public_b/g" cluster.yml
sed -i "s/private_a/$private_a/g" cluster.yml
sed -i "s/private_b/$private_b/g" cluster.yml

# 클러스터 생성
eksctl create cluster -f cluster.yml