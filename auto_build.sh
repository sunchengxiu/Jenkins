#!/bin/sh

#scheme  游戏渠道版本
scheme="jenkins"
project_path="/Users/sunchengxiu/Desktop/自动化脚本/jenkins"
development_team="9CVMN4UZK4"
code_sign="aedaa468-6fd2-485c-8fe4-cccc2a1a9842"
sign_name="RongCloud.jenkins"

autoBuild() {

	#打包之前先清理一下工程
	xcodebuild clean \
	-scheme ${scheme} \
	-configuration Release 
	if [[ $? != 0 ]]; then
		echo "clean failue"
		exit
	fi
echo "clean success"
	#开始编译工程 - 导出.xcarchive文件
	xcodebuild archive \
	-project "${project_path}/${scheme}.xcodeproj" \
	-scheme ${scheme} \
	-configuration Release \
	-archivePath "./build/${scheme}.xcarchive" \
	# CODE_SIGN_IDENTITY="iPhone Developer: 承秀 孙 (BF747PX67Y)" \
	# DEVELOPMENT_TEAM=${development_team} \
	# PROVISIONING_PROFILE=${code_sign} \
	# PROVISIONING_PROFILE_SPECIFIER=${sign_name}
	if [[ $? != 0 ]]; then
		exit
	fi

	#导出ipa包
	xcodebuild -exportArchive \
	-archivePath "${project_path}/build/${scheme}.xcarchive" \
	-exportPath "~/Desktop/PublishIPA/${scheme}" \
	-exportOptionsPlist "${project_path}/ExportOptions.plist"
	if [[ $? != 0 ]]; then
		exit
	fi
}
autoBuild

