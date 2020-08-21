# VPC�T�u�l�b�g��\�`���ňꗗ�\������
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
        Write-Host "VPC�T�u�l�b�g��\�`���ŕ\�����܂�"
        Write-Host "$script_name (���Ƀp�����[�^�͕s�v)"
        
        exit
    }


    $ret_val = (aws ec2 describe-subnets | ConvertFrom-Json)

    $vpceps = @()

    $ret_val.Subnets | ForEach-Object{
        $tmp_hash = @{}

        $tmp_hash.Add('VpcId',$_.VpcId)
        $tmp_hash.Add('AvailabilityZone', $_.AvailabilityZone)
        $tmp_hash.Add('SubnetId', $_.SubnetId)
        $tmp_hash.Add('CidrBlock', $_.CidrBlock)
        $tmp_hash.Add('AvailabilityZoneId', $_.AvailabilityZoneId)
        $tmp_hash.Add('Tags', $_.Tags)

        # Key - Value���AKey1, Key2, Key3...�֏c���ϊ������{
        $vpcep_hash = $tmp_hash | %{ New-Object PSCustomObject -Property $_ }
        $vpceps += $vpcep_hash
    }

    # �\�`���ŕ\��
    $vpceps | Format-Table -Property VpcId,AvailabilityZone,CidrBlock,SubnetId,AvailabilityZoneId,Tags
}

Main
