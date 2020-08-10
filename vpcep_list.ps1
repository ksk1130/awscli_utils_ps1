# VPC�G���h�|�C���g��\�`���ňꗗ�\������
param(
    [switch]$help
      )

# ����`�ϐ����֎~
Set-StrictMode -Version 2.0

# �G���[�����������_�ŏ����I��
$ErrorActionPreference = "stop"

# �又��
function script:Main() {
    $script_name = Split-Path -Leaf $PSCommandPath
    if($help -eq $true){
        Write-Host "VPC�G���h�|�C���g��\�`���ŕ\�����܂�"
        Write-Host "$script_name (���Ƀp�����[�^�͕s�v)"
        
        exit
    }


    $ret_val = (aws ec2 describe-vpc-endpoints | ConvertFrom-Json)

    $vpceps = @()

    $ret_val.VpcEndpoints | ForEach-Object{
        $tmp_hash = @{}

        $tmp_hash.Add('vpcid',$_.VpcId)
        $tmp_hash.Add('servicename', $_.ServiceName)
        $tmp_hash.Add('vpcendpointid', $_.VpcEndpointId)
        $tmp_hash.Add('vpcendpointtype', $_.VpcEndpointType)
        $tmp_hash.Add('state', $_.State)
        $tmp_hash.Add('subnetids', $_.SubnetIds)
        $tmp_hash.Add('routes', $_.RouteTableIds)
        $tmp_hash.Add('sgs', $_.Groups)

        # Key - Value���AKey1, Key2, Key3...�֏c���ϊ������{
        $vpcep_hash = $tmp_hash | %{ New-Object PSCustomObject -Property $_ }
        $vpceps += $vpcep_hash
    }

    # �\�`���ŕ\��
    $vpceps | Format-Table -Property vpcid,vpcendpointid,servicename,vpcendpointtype,state,subnetids,routes,sgs
}

Main
