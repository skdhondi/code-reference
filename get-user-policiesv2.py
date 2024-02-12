import boto3
import csv
import json

def get_policy_permissions(policy_arn):
    # Create an IAM client
    iam = boto3.client('iam')

    # Get the policy details
    response = iam.get_policy(PolicyArn=policy_arn)
    policy_version = response['Policy']['DefaultVersionId']

    # Get the policy document
    policy_document_response = iam.get_policy_version(PolicyArn=policy_arn, VersionId=policy_version)
    policy_document = json.dumps(policy_document_response['PolicyVersion']['Document'], indent=2)

    return policy_document

def get_inline_policy_permissions(user,policy):
    # Create an IAM client
    iam = boto3.client('iam')

    # Get the policy details
    response = iam.get-user-policy(PolicyArn=policy_arn)
    policy_version = response['Policy']['DefaultVersionId']

    # Get the policy document
    policy_document_response = iam.get_policy_version(PolicyArn=policy_arn, VersionId=policy_version)
    policy_document = json.dumps(policy_document_response['PolicyVersion']['Document'], indent=2)

    return policy_document    

def check_full_access(policy_document):
    # Check if the policy grants full access
    full_access_keywords = ['Effect', 'Action', 'Resource']
    for keyword in full_access_keywords:
        if keyword not in policy_document:
            return False
    return True

def get_attached_policies_for_user(user_name):
    # Create an IAM client
    iam = boto3.client('iam')

    # Get attached managed policies
    managed_policies_response = iam.list_attached_user_policies(UserName=user_name)
    attached_managed_policies = managed_policies_response['AttachedPolicies']

    # Get inline policies
   # inline_policies_response = iam.list_user_policies(UserName=user_name)
    #inline_policies = [{'PolicyName': policy} for policy in inline_policies_response['PolicyNames']]

    # Get group policies
    group_policies_response = iam.list_groups_for_user(UserName=user_name)
    group_policies = []
    for group in group_policies_response['Groups']:
        group_name = group['GroupName']
        group_policies_response = iam.list_attached_group_policies(GroupName=group_name)
        group_policies.extend(group_policies_response['AttachedPolicies'])

    return attached_managed_policies, group_policies

def export_policies_to_csv(user_name, managed_policies, group_policies):
    # Create a CSV file
    csv_file_name = f"{user_name}_full_access_policies.csv"
    with open(csv_file_name, 'w', newline='') as csvfile:
        fieldnames = ['PolicyType', 'PolicyName', 'PolicyArn', 'PolicyDocument']
        csv_writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        csv_writer.writeheader()

        # Write attached managed policies with full access
        for policy in managed_policies:
            policy_arn = policy['PolicyArn']
            policy_document = get_policy_permissions(policy_arn)
            if check_full_access(policy_document):
                csv_writer.writerow({'PolicyType': 'Managed ', 'PolicyName': policy['PolicyName'], 'PolicyArn': policy_arn, 'PolicyDocument': policy_document})

        # Write inline policies with full access
   #     for policy in inline_policies:
   #         policy_arn = policy['PolicyArn']
   #         policy_document = get_policy_permissions(policy_arn)
   #         if check_full_access(policy_document):
   #             csv_writer.writerow({'PolicyType': 'Inline', 'PolicyName': policy['PolicyName'], 'PolicyDocument': policy_document})

        # Write group policies with full access
        for policy in group_policies:
            policy_arn = policy['PolicyArn']
            policy_document = get_policy_permissions(policy_arn)
            if check_full_access(policy_document):
                csv_writer.writerow({'PolicyType': 'Group', 'PolicyName': policy['PolicyName'], 'PolicyArn': policy_arn, 'PolicyDocument': policy_document})

    print(f"Full access IAM policies for user '{user_name}' exported to '{csv_file_name}'")

if __name__ == "__main__":
    user_name = input("Enter the IAM username: ")

    managed_policies, group_policies = get_attached_policies_for_user(user_name)

    export_policies_to_csv(user_name, managed_policies, group_policies)
