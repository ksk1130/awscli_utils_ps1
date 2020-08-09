# VPC�G���h�|�C���g���폜����R�}���h��Powershell�Ń��b�v��������
param(
    [string]$vpc_endpoint_ids                 # vpc-endpoint-ids
      )

# ����`�ϐ����֎~
Set-StrictMode -Version 2.0

# �G���[�����������_�ŏ����I��
$ErrorActionPreference = "stop"

# �又��
function script:Main() {
    # �����`�F�b�N
    if([string]::IsNullorEmpty($vpc_endpoint_ids)){
        Write-Host 'VPC-ENDPOINT-ID���w�肵�Ă�������'
        exit
    }

    # �e��p�����[�^�����VPC�G���h�|�C���g���쐬
    aws ec2 delete-vpc-endpoints `
    --vpc-endpoint-ids $vpc_endpoint_ids 

}

Main
