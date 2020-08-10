# VPC�G���h�|�C���g���쐬����R�}���h��Powershell�Ń��b�v��������
param(
    [string]$vpc_id                           # vpc-id
   ,[string]$vpc_endpoint_type='Interface'    # vpc-endpoint-type
   ,[string]$service_name                     # service-name
   ,[string]$subnet_id                        # subnet-id
   ,[string]$security_group_id                # security-group-id
   ,[switch]$help
      )

# ����`�ϐ����֎~
Set-StrictMode -Version 2.0

# �G���[�����������_�ŏ����I��
$ErrorActionPreference = "stop"

# �又��
function script:Main() {
    $script_name = Split-Path -Leaf $PSCommandPath
    if($help -eq $true){
        Write-Host "�w�肵���p�����[�^��VPC�G���h�|�C���g���쐬���܂�"
        Write-Host "$script_name"
        Write-Host " -vpc_id <vpc-id>"
        Write-Host " -vpc_endpoint_type <vpc-endpoint-type>(�f�t�H���g��'Interface'�ł��B'Gateway'�̏ꍇ�w�肵�Ă�������)"
        Write-Host " -service_name <service-name>"
        Write-Host " -subnet_id <subnet-id>"
        Write-Host " -security_group_id <security-group-id>"
        
        exit
    }

    # �����`�F�b�N
    if([string]::IsNullorEmpty($vpc_id) -Or [string]::IsNullorEmpty($service_name) -Or [string]::IsNullorEmpty($subnet_id) -Or [string]::IsNullorEmpty($security_group_id)){
        Write-Host 'VPC-ID, SERVICE-NAME, SUBNET-ID, SECURITY-GROUP-ID���w�肵�Ă�������'
        Write-Host "�g������ $script_name -help �Ŋm�F���Ă�������"
        exit
    }

    # �e��p�����[�^�����VPC�G���h�|�C���g���쐬
    aws ec2 create-vpc-endpoint `
    --vpc-id $vpc_id `
    --vpc-endpoint-type $vpc_endpoint_type `
    --service-name $service_name `
    --subnet-id $subnet_id `
    --security-group-id $security_group_id

}

Main
